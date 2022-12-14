// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "@openzeppelin/contracts-upgradeable/access/IAccessControlUpgradeable.sol";

/**
 * @title IETSAccessControls
 * @author Ethereum Tag Service <team@ets.xyz>
 *
 * @notice This is the interface for the ETSAccessControls contract which allows ETS Core Dev
 * Team to administer roles and control access to various parts of the ETS Platform.
 * ETSAccessControls contract contains a mix of public and administrator only functions.
 */
interface IETSAccessControls is IAccessControlUpgradeable {
    /**
     * @dev emitted when the ETS Platform address is set.
     *
     * @param newAddress wallet address platform is being set to.
     * @param prevAddress previous platform address.
     */
    event PlatformSet(address newAddress, address prevAddress);

    /**
     * @dev emitted when a Publisher contract is added & enabled in ETS.
     *
     * Publisher contracts are not required implement all ETS Core API functions. Therefore, to ease
     * testing of ETS Core API fuinctions, ETS permits addition of ETS owned wallet addresses as Publishers.
     *
     * @param publisher Publisher contract address.
     * @param isAdmin Publisher address is ETS administrator (used for testing).
     */
    event PublisherAdded(address publisher, bool isAdmin);

    /**
     * @dev emitted when a Publisher contract is paused or unpaused.
     *
     * @param publisher Address that had pause toggled.
     */
    event PublisherPauseToggled(address publisher);

    /**
     * @notice Sets the Platform wallet address. Can only be called by address with DEFAULT_ADMIN_ROLE.
     *
     * @param _platform The new Platform address to set.
     */
    function setPlatform(address payable _platform) external;

    /**
     * @notice Adds a Publisher contract to ETS. Can only be called by address
     * with DEFAULT_ADMIN_ROLE.
     *
     * @param _publisher Address of the Publisher contract. Must conform to IETSPublisher.
     * @param _name Human readable name of the Publisher.
     */
    function addPublisher(address _publisher, string calldata _name) external;

    /**
     * @notice Pauses/Unpauses a Publisher contract. Can only be called by address
     * with DEFAULT_ADMIN_ROLE.
     *
     * @param _publisher Address of the Publisher contract.
     */
    function toggleIsPublisherPaused(address _publisher) external;

    /**
     * @notice Sets the role admin for a given role. An address with role admin can grant or
     * revoke that role for other addresses. Can only be called by address with DEFAULT_ADMIN_ROLE.
     *
     * @param _role bytes32 representation of role being administered.
     * @param _adminRole bytes32 representation of administering role.
     */
    function setRoleAdmin(bytes32 _role, bytes32 _adminRole) external;

    /**
     * @notice Checks whether given address has SMART_CONTRACT role.
     *
     * @param _addr Address being checked.
     * @return boolean True if address has SMART_CONTRACT role.
     */
    function isSmartContract(address _addr) external view returns (bool);

    /**
     * @notice Checks whether given address has DEFAULT_ADMIN_ROLE role.
     *
     * @param _addr Address being checked.
     * @return boolean True if address has DEFAULT_ADMIN_ROLE role.
     */
    function isAdmin(address _addr) external view returns (bool);

    /**
     * @notice Checks whether given address has PUBLISHER role.
     *
     * @param _addr Address being checked.
     * @return boolean True if address has PUBLISHER role.
     */
    function isPublisher(address _addr) external view returns (bool);

    /**
     * @notice Checks whether given address has PUBLISHER_ADMIN role.
     *
     * @param _addr Address being checked.
     * @return boolean True if address has PUBLISHER_ADMIN role.
     */
    function isPublisherAdmin(address _addr) external view returns (bool);

    /**
     * @notice Checks whether given Publisher Name is a registered Publisher.
     *
     * @param _name Name being checked.
     * @return boolean True if _name is a Publisher.
     */
    function isPublisherByName(string calldata _name) external view returns (bool);

    /**
     * @notice Checks whether given address is a registered Publisher.
     *
     * @param _addr Address being checked.
     * @return boolean True if address is a registered Publisher.
     */
    function isPublisherByAddress(address _addr) external view returns (bool);

    /**
     * @notice Checks whether given address is a registered Publisher and not paused.
     *
     * @param _addr Address being checked.
     * @return boolean True if address is a Publisher and not paused.
     */
    function isPublisherAndNotPaused(address _addr) external view returns (bool);

    /**
     * @notice Get publisher address from it's name.
     *
     * @param _name Name of publisher.
     * @return Address of publisher.
     */
    function getPublisherAddressFromName(string calldata _name) external view returns (address);

    /**
     * @notice Get publisher name from it's address.
     *
     * @param _address Adsdress of publisher.
     * @return Name of publisher.
     */
    function getPublisherNameFromAddress(address _address) external view returns (string calldata);

    /**
     * @notice Returns wallet address for ETS Platform.
     *
     * @return ETS Platform address.
     */
    function getPlatformAddress() external view returns (address payable);
}
