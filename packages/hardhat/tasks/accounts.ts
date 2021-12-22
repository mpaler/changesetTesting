import '@nomiclabs/hardhat-ethers';
import { Signer } from "@ethersproject/abstract-signer";
import { task } from "hardhat/config";

task('accounts', 'Prints the list of accounts', async (_args, hre) => {
  const accounts: Signer[] = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(await account.getAddress());
  }
});
