import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log(`Deploying contracts with the account: ${deployer.address}`);
  console.log(`Account balance: ${(await deployer.getBalance()).toString()}`);

  const NFT = await ethers.getContractFactory("NFT");
  // calling deploy() will return an async Promise that we can await on
  const nft = await NFT.deploy();

  console.log(`Contract deployed to address: ${nft.address}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
