import { ethers } from "hardhat";

async function main() {
  const NFT = await ethers.getContractFactory("NFT");

  const nft = await NFT.deploy("NFT", "nft");
  await nft.deployed();
  console.log("Contract deployed to address:", nft);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
