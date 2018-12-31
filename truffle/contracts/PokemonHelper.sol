pragma solidity >=0.4.21 <0.6.0;

import "./PokemonContract.sol";


contract PokemonHelper is PokemonContract{
    
    
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
}


