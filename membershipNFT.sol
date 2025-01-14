// SPDX-License-Identifier: GPL-3.0
/*
    *** Sistema de Membresía NFT con Acceso Exclusivo ***
    Descripción: Crear un sistema de membresías donde los poseedores de un NFT tienen acceso exclusivo a ciertos 
    contenidos o beneficios (como acceso a eventos, descuentos, o incluso otros NFTs).
    - Características Originales:
    Los NFTs de membresía pueden tener niveles de acceso (ej. oro, plata, bronce).
    Integrar una función de "quema" del NFT para reclamar beneficios únicos.
*/
pragma solidity  >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MembershipNFT is ERC721Enumerable, Ownable{
    //Errors
    error MembershipInsufficientBalance();
    error MembershipNonExistentToken();
    error MembershipNotTheOwner();

    //Events
    event NewMembershipMinted(address indexed to, uint256 tokenID, MembershipLevel level);
    event MembershipRenewed(address indexed to, uint256 tokenID, MembershipLevel level, uint256 expiration);


    //Variables
    uint256 private _currentTokenId;
    enum MembershipLevel {Bronze, Silver, Gold}

    uint256 bronzePrice = 0.01 ether;
    uint256 silverPrice = 0.1 ether;
    uint256 goldPrice = 0.5 ether;

    mapping (uint256 tokenID => MembershipLevel) public membershipLevels;
    mapping (uint256 tokenID => uint256 expiration) public membershipExpiration;
    

    constructor() ERC721("Membership","MSP") Ownable(msg.sender){
        _currentTokenId = 0;
    }

    function mintMembership (MembershipLevel level) external payable onlyOwner
    {
        uint256 price = getPriceForLevel(level);

        if (msg.value < price){
            revert MembershipInsufficientBalance();
        }

        _currentTokenId = _currentTokenId + 1;

        _safeMint(msg.sender, _currentTokenId);
        membershipLevels[_currentTokenId] = level;
        membershipExpiration[_currentTokenId] = block.timestamp + 365 days;

        emit NewMembershipMinted (msg.sender, _currentTokenId, level);
    }

    function renewMembership(uint256 tokenID) external payable onlyOwner
    {
        if (!_exists(tokenID)){
            revert MembershipNonExistentToken();
        }
        if (ownerOf(tokenID) != msg.sender){
            revert MembershipNotTheOwner();
        }

        MembershipLevel level = membershipLevels[tokenID];
        uint256 price = getPriceForLevel(level);

        if (msg.value < price) {
            revert MembershipInsufficientBalance();
        }

        uint256 newExpirationData = membershipExpiration[tokenID] + 256 days;
        membershipExpiration[tokenID] = newExpirationData;

        emit MembershipRenewed(msg.sender, tokenID, level, newExpirationData);
    }

    function getPriceForLevel (MembershipLevel _level) public view returns (uint256) {
        if (_level == MembershipLevel.Gold){
            return goldPrice;
        } else if (_level == MembershipLevel.Silver){
            return silverPrice;
        } else {
            return bronzePrice;
        }
    }

    function _exists (uint256 tokenID) internal view returns (bool){
        return ownerOf(tokenID) != address(0);
    }

    function checkMembershipLevel(address _user) public view returns (MembershipLevel) {
        uint256 balance = balanceOf(_user);

        if(balance==0) {
            revert MembershipInsufficientBalance();
        }

        MembershipLevel level = MembershipLevel.Bronze;

        for(uint256 i = 0; i<balance-1; i++) {
            uint256 tokenID = tokenOfOwnerByIndex(_user, i);
            MembershipLevel currentLevel = membershipLevels[tokenID];

            if(currentLevel>level) {
                level = currentLevel;
            }
        }  
        return level; 
    }

    function withdraw () external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

}