# Exclusive Access NFT Membership System

## Description
This smart contract, implemented in Solidity, enables the creation of a membership system using NFTs (ERC721 tokens). NFT holders can enjoy exclusive benefits such as access to events, discounts, or even the ability to claim other NFTs.

### Main Features:
- **Membership Levels:** NFTs are classified into three levels: Gold, Silver, and Bronze, each with associated prices and benefits.
- **Active Membership:** Tokens have a membership duration (1 year by default) that can be renewed.
- **Burn NFTs:** Users can burn their NFTs to claim unique benefits.
- **Withdraw Funds:** The contract owner can withdraw the funds accumulated in the contract.

## Technical Details

### Extensions Used:
- **ERC721Enumerable:** Enables enumeration of owner tokens.
- **Ownable:** Provides access control for critical functions such as withdrawing funds.

## Implementation
This contract leverages the **OpenZeppelin** library, using standard extensions for ERC721 contracts and access control. It is licensed under GPL-3.0.

## How to Use
1. **Deploy the contract on an Ethereum-compatible network.**
2. **Mint NFTs of different levels by sending the corresponding amount of Ether.**
3. **Renew or burn tokens based on desired benefits.**
4. **Check membership status and access the associated benefits.**

## Security Considerations
- The contract uses the `onlyOwner` modifier to protect critical functions.
- Ensures tokens exist before performing operations like renewals or burns.
- Reverts with errors in case of invalid conditions, such as insufficient balance or lack of ownership.

**Author:** Developed as an educational example for NFT-based systems.
