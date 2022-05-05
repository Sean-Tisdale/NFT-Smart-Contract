import * as dotenv from "dotenv";

import { HardhatUserConfig } from "hardhat/config";
import "@nomiclabs/hardhat-etherscan";
import "@nomiclabs/hardhat-waffle";
import "@typechain/hardhat";
import "hardhat-gas-reporter";
import "solidity-coverage";

dotenv.config();

require("dotenv").config();
require("@nomiclabs/hardhat-ethers");
const { ALCHEMY_API_URL, PRIVATE_KEY } = process.env;

task(
  "accounts",
  "Prints the list of accounts",
  async (taskArgs: any, hre: { ethers: { getSigners: () => any } }) => {
    const accounts = await hre.ethers.getSigners();

    for (const account of accounts) {
      console.log(account.address);
    }
  }
);

const config: HardhatUserConfig = {
  solidity: "0.8.1",
  defaultNetwork: "rinkeby",
  networks: {
    hardhat: {},
    rinkeby: {
      url: ALCHEMY_API_URL,
      accounts: [`0x${PRIVATE_KEY}`],
    },
  },
};

export default config;
