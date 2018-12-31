pragma solidity >=0.4.21 <0.6.0;

import "./PokemonContract.sol";

contract PokemonTrade is PokemonContract{
    
    function trade(address _from, address _to, uint256 _pokemonId) public {
        playerPokemonsCount[_to]++;
        playerPokemonsCount[msg.sender]--;
        PokemonToPlayer[_pokemonId] = _to;
    }
    
}
    