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

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/IERC721Enumerable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

abstract contract MembershipNFT is ERC721, IERC721Enumerable, Ownable{
    
    uint256 private _currentTokenId;
    enum MembershipLevel {Bronze, Silver, Gold}

    mapping (uint256 tokenID => MembershipLevel) public membershipLevels;
    // mapping (uint256 tokenID => uint256 expiration) public membershipExpiration

    uint256 bronzePrice = 0.01 ether;
    uint256 silverPrice = 0.1 ether;
    uint256 goldPrice = 0.5 ether;

    constructor() ERC721("Conquer Membership","CQM") Ownable(msg.sender){
        _currentTokenId = 0;
    }

    // function mintConquerMembership (MembershipLevel level) external payable 
    // {
    //     uint256 price = getPriceForLevel(level);
    // }

    function getPriceForLevel (MembershipLevel _level) public view returns (uint256) {
        if (_level == MembershipLevel.Gold){
            return goldPrice;
        }else if (_level == MembershipLevel.Silver){
            return silverPrice;
        }else {
            return bronzePrice;
        }
    }

}