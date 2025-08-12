// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {console, Test} from "forge-std/Test.sol";
import {RebaseToken} from "../src/RebaseToken.sol";
import {Vault} from "../src/Vault.sol";
import {CCIPLocalSimulatorFork} from "@chainlink/local//src/ccip/CCIPLocalSimulatorFork.sol";

import {IRebaseToken} from "../src/interfaces/IRebaseToken.sol";

contract RebaseTokenTest is Test {
    address owner = makeAddr("owner");
    uint256 sepoliaFork;
    uint256 arbSepoliaFork;

    CCIPLocalSimulatorFork ccipLocalSimulatorFork;

    RebaseToken sepoliaToken;
    RebaseToken arbSepoliaToken;
    Vault vault;

    function setUp() public {
        sepoliaFork = vm.createSelectFork("sepolia");
        arbSepoliaFork = vm.createFork("arb-sepolia");

        ccipLocalSimulatorFork = new CCIPLocalSimulatorFork();
        vm.makePersistent(address(ccipLocalSimulatorFork));

        // 1. Sepolia
        vm.startPrank(owner);
        sepoliaToken = new RebaseToken();
        vault = new Vault(IRebaseToken(address(sepoliaToken)));


        vm.stopPrank();

        // 2. Arb Sepolia
        vm.selectFork(arbSepoliaFork);
        arbSepoliaToken = new RebaseToken();
        vm.startPrank(owner);

        vm.stopPrank();
    }
}
