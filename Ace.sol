// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts-upgradeable@4.9.0/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable@4.9.0/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable@4.9.0/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable@4.9.0/token/ERC20/extensions/draft-ERC20PermitUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable@4.9.0/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable@4.9.0/proxy/utils/UUPSUpgradeable.sol";

contract MetaTraceUtilityToken is Initializable, ERC20Upgradeable, ERC20BurnableUpgradeable, AccessControlUpgradeable, ERC20PermitUpgradeable, UUPSUpgradeable {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant UPGRADER_ROLE = keccak256("UPGRADER_ROLE");

    constructor() {
        _disableInitializers();
    }

    function initialize() initializer public {
        __ERC20_init("MetaTrace Utility Token", "ACE");
        __ERC20Burnable_init();
        __AccessControl_init();
        __ERC20Permit_init("MetaTrace Utility Token");
        __UUPSUpgradeable_init();

        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        //add manager address for minter role
        _grantRole(MINTER_ROLE, 0xDa45fE54B496B6dEed28364E032693e750A09520);
        _grantRole(MINTER_ROLE, msg.sender);
        _grantRole(UPGRADER_ROLE, msg.sender);
    }

    function mint(address to, uint256 amount) public virtual onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    function _authorizeUpgrade(address newImplementation)
        internal
        onlyRole(UPGRADER_ROLE)
        override
    {}

    function decimals() public view virtual override returns (uint8) {
        return 2;
    }
}