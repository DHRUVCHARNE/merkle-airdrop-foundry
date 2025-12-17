
# Merkle Airdrop (Foundry)

A **production-grade Merkle Airdrop system** built with **Foundry**, featuring:

* ERC20 token distribution using **Merkle proofs**
* **Gas-payer claim model** (meta-transaction style)
* Off-chain signature verification
* Fully scriptable deployments
* zkSync-compatible build pipeline
* Sepolia testnet live deployment

This repository demonstrates **real-world Web3 backend engineering patterns** used in token distributions, allowlists, and airdrops.

---

## ✨ Features

* ✅ **Merkle Tree–based eligibility**
* ✅ **ERC20 token airdrop**
* ✅ **Gasless claims** via signed messages
* ✅ **Secure ECDSA signature verification**
* ✅ **Foundry unit tests**
* ✅ **Scripted deployments**
* ✅ **zkSync-ready architecture**
* ✅ **Sepolia testnet deployment**

---

## 📜 Contracts

### 🔹 MerkleAirDrop

* Verifies Merkle proofs
* Validates user signatures
* Allows third-party gas payers to submit claims
* Transfers ERC20 tokens to eligible users

### 🔹 MerkoraToken

* Standard ERC20 token
* Minted supply transferred to the airdrop contract

---

## 🚀 Live Deployment (Sepolia)

| Contract          | Address                                      |
| ----------------- | -------------------------------------------- |
| **MerkleAirDrop** | `0xB501c1d73bcBE252d8D5ec78cAE33cB7fB85fF90` |
| **MerkoraToken**  | `0xd8752d85ce79836335F845551F06207e7338EF7F` |

📍 **Network:** Ethereum Sepolia Testnet

---

## 🔍 How the Airdrop Works

1. **Off-chain**

   * Eligible users are stored in a Merkle tree
   * Each user signs a message authorizing the claim

2. **On-chain**

   * Anyone (gas payer) submits the claim
   * Contract verifies:

     * Merkle proof
     * Signature authenticity
     * Claim uniqueness
   * Tokens are transferred to the user

This design enables **gasless claims** for users.

---

## 🧪 Testing

Run unit tests (EVM):

```bash
forge test
```

> ⚠️ `forge test --zksync` is **not supported** due to Foundry zkSync limitations.
> zkSync is supported for **builds and scripts only**.

---

## 🛠 Build

### Standard build

```bash
forge build
```

### zkSync build

```bash
forge build --zksync
```


## 📁 Project Structure

```
src/
 ├─ MerkleAirdrop.sol
 └─ MerkoraToken.sol

test/
 └─ MerkleAirdrop.t.sol

script/
 ├─ MerkleAirdrop.s.sol
 ├─ Interaction.s.sol
 ├─ GenerateInput.s.sol
 └─ MakeMerkle.s.sol
```

---

## 🔐 Security Notes

* Merkle proofs prevent unauthorized claims
* ECDSA signatures prevent replay attacks
* Claims are single-use
* ERC20 allowance is tightly controlled

> This project is for **educational and demonstration purposes** and has not been audited.

---

## 🧠 Tech Stack

* **Solidity ^0.8.24**
* **Foundry**
* **OpenZeppelin Contracts**
* **Murky (Merkle trees)**
* **Ethereum Sepolia**

---

## 📜 License

MIT License

---

## 🙌 Author

**Dhruv Charne**
GitHub: [@DHRUVCHARNE](https://github.com/DHRUVCHARNE)

