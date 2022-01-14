import 'hardhat-deploy';
import 'hardhat-ethernal';
import '@typechain/hardhat';
import 'hardhat-abi-exporter';
import "@nomiclabs/hardhat-web3";
import '@nomiclabs/hardhat-ethers';
import '@nomiclabs/hardhat-waffle';
import '@nomiclabs/hardhat-truffle5';
import '@nomiclabs/hardhat-etherscan';
import '@openzeppelin/hardhat-upgrades';

import './tasks/accounts';

import { resolve } from "path";

import { config as dotenvConfig } from "dotenv";
import { HardhatUserConfig } from "hardhat/types";

dotenvConfig({ path: resolve(__dirname, "../../.env") });

// Ensure that we have all the environment variables we need.
const mnemonic: string | undefined = process.env.MNEMONIC;

if (!mnemonic) {
  throw new Error("Please set your MNEMONIC in a .env file");
}

const infuraApiKey: string | undefined = process.env.INFURA_API_KEY;

if (!infuraApiKey) {
  throw new Error("Please set your INFURA_API_KEY in a .env file");
}

const config: HardhatUserConfig = {
  networks: {
    hardhat: {
      accounts: mnemonic ? { mnemonic } : undefined,
      chainId: 31337,
    },
    localhost: {
      url: "http://localhost:8545",
      accounts: mnemonic ? { mnemonic } : undefined,
      chainId: 31337,
    },
    mumbai: {
      url: `https://polygon-mumbai.infura.io/v3/${process.env.INFURA_API_KEY}`,
      chainId: 80001,
      accounts: mnemonic ? { mnemonic } : undefined,
    }
  },
  paths: {
    artifacts: '../app/artifacts',
  },
  abiExporter: {
    path: '../subgraph/abi',
    runOnCompile: true,
    clear: true,
    pretty: true,
    flat: false,
  },
  namedAccounts: {
    accountHashtagAdmin: {
      default: 0,
      mumbai: "0x93A5f58566D436Cae0711ED4d2815B85A26924e6",
    },
    accountHashtagPublisher: {
      default: 1,
      mumbai: "0xE9FBC1a1925F6f117211C59b89A55b576182e1e9",
    },
    accountHashtagPlatform: {
      default: 2,
      mumbai: "0x60F2760f0D99330A555c5fc350099b634971C6Eb",
    },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
  typechain: {
    outDir: '../app/types',
  },
  solidity: {
    compilers: [
      {
        version: "0.6.12",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
      {
        version: "0.8.2",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
    ],
  },
};

export default config;
