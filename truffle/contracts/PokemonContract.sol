pragma solidity >=0.4.21 <0.6.0;


contract PokemonContract {
    
    struct Pokemon {
        string name;
        string types;
        string image;
        uint hp;
        uint atk;
        uint def;
    }

    Pokemon[] public allPokemons;
    Pokemon[] public PokemonMap;
    uint upgradeFee = 0.001 ether;

    mapping (uint => address) public PokemonToPlayer;
    mapping (address => uint) playerPokemonsCount;


    modifier isPokemonOf(uint _pokemonId) {
        require(msg.sender == PokemonToPlayer[_pokemonId]);
        _;
    }

    function _createNewPokemon(string _name, string _types, string _image, 
                    uint _hp, uint _atk,uint _def) internal {
        PokemonMap.push(Pokemon(_name, _types,  _image, _hp, _atk, _def));
    }

    
    function upgrade(uint _PokemonId) external payable {
        require(msg.value == upgradeFee);
        allPokemons[_PokemonId].hp += 10;
        allPokemons[_PokemonId].atk += 10;
        allPokemons[_PokemonId].def += 10;
    }

    function getPlayerPokemonCount(address _addr) public view returns(uint){
        uint count = 0;
        for(uint i = 0;i < allPokemons.length;i++){
            if(PokemonToPlayer[i] == _addr){
                count += 1;
            }
        }
        return count;
    }
    
    function getPlayerPokemon(address _addr, uint _index) public view returns(
        string name,
        string types,
        string image,
        uint hp,
        uint atk,
        uint def
        ){
        Pokemon[] results;
        for(uint i = 0;i < allPokemons.length;i++){
            if(PokemonToPlayer[i] == _addr){
                uint _pokemonId = i;
                results.push(Pokemon(PokemonMap[_pokemonId].name, PokemonMap[_pokemonId].types, 
                PokemonMap[_pokemonId].image,PokemonMap[_pokemonId].hp,PokemonMap[_pokemonId].atk,
                PokemonMap[_pokemonId].def));
            }
        }
        if(_index >= getPlayerPokemonCount(_addr)){
            if(results.length > 0){
                return (results[0].name,results[0].types,results[0].image,results[0].hp,results[0].atk, results[0].def);
            }
            else{
                return (" "," "," ",0,0,0);
            }
        }
        else{
            Pokemon pokemon = results[_index];
            return (pokemon.name,pokemon.types,pokemon.image,pokemon.hp,pokemon.atk, pokemon.def);
        }
    }
 
    function trade(address _from, address _to, uint256 _pokemonId) public {
        playerPokemonsCount[_to]++;
        playerPokemonsCount[msg.sender]--;
        PokemonToPlayer[_pokemonId] = _to;
    }
}



