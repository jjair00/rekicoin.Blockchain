// SPDX-License-Identifier: UNLICENSED
// RekiCoins ICO

// Versión del compilador
pragma solidity ^0.8.18;

contract rekicoin_ico {
    // Introduciendo el número máximo de rekicoin a la cuenta
    uint public max_rekicoins = 1000000;

    // Tasa de conversión USD a RKC
    uint public usd_to_rekicoins = 1000;

    // Introduciendo número total de rekicoins que han sido comprados por inversionistas
    uint public total_rekicoins_bought = 0;

    // Mapeo de dirección de inversionistas a activos en rekicoin y USD
    mapping(address => uint) equity_rekicoins;
    mapping(address => uint) equity_usd;

    // Chequeando si inversionista puede comprar tokens
    modifier can_buy_rekicoins(uint usd_invested) {
        require(usd_invested * usd_to_rekicoins + total_rekicoins_bought <= max_rekicoins);
        _;
    }

    // Obteniendo el capital invertido en tokens
    function getEquityRekicoins(address investor) external view returns (uint) {
        return equity_rekicoins[investor];
    }

    // Obteniendo el capital invertido en USD
    function getEquityUSD(address investor) external view returns (uint) {
        return equity_usd[investor];
    }

    // Comprando tokens
    function buyRekicoins(address investor, uint usd_invested) external can_buy_rekicoins(usd_invested) {
        uint rekicoins_bought = usd_invested * usd_to_rekicoins;
        equity_rekicoins[investor] += rekicoins_bought;
        equity_usd[investor] = equity_rekicoins[investor] / 1000;
        total_rekicoins_bought += rekicoins_bought;
    }

    // Vendiendo tokens
    function sellRekicoins(address investor, uint rekicoins_sold) external {
        equity_rekicoins[investor] -= rekicoins_sold;
        equity_usd[investor] = equity_rekicoins[investor] / 1000;
        total_rekicoins_bought -= rekicoins_sold;
    }
}
