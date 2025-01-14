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

## How to Deploy and Test the Contract in Remix

### **Step 1: Open Remix**
1. Go to [Remix IDE](https://remix.ethereum.org/).

### **Step 2: Create a New File**
1. In the left-hand file explorer, click the "New File" button.
2. Name the file `MembershipNFT.sol`.
3. Copy and paste the contract code into this file.

### **Step 3: Configure the Compiler**
1. Click the **Solidity Compiler** icon (a gear with an "S").
2. Select a compiler version compatible with the pragma directive in your code (e.g., `v0.8.19`).
3. Click the **Compile MembershipNFT.sol** button.

### **Step 4: Deploy the Contract**
1. Click the **Deploy & Run Transactions** icon (a rocket icon).
2. Under "Environment," select **JavaScript VM (London)** for testing in a local blockchain simulation.
3. Ensure the `MembershipNFT` contract is selected under the "Contract" dropdown.
4. Click the **Deploy** button.

### **Step 5: Interact with the Contract**
1. **Mint Membership:**
   - Use the `mintMembership` function.
   - Input a level (`0` for Bronze, `1` for Silver, `2` for Gold) and send the required amount of Ether (`bronzePrice`, `silverPrice`, or `goldPrice`).
2. **Renew Membership:**
   - Use the `renewMembership` function with a valid token ID and the required Ether.
3. **Check Membership Level:**
   - Use the `checkMembershipLevel` function to see the highest membership level of a specific user.
4. **Burn Membership:**
   - Use the `burnMembership` function to destroy a token you own.
5. **Check Membership Activity:**
   - Use the `isMembershipActive` function to check if your membership is still valid.
6. **Withdraw Funds:**
   - If you are the contract owner, use the `withdraw` function to transfer the contract balance to your wallet.

**Author:** Developed as an educational example for NFT-based systems.
