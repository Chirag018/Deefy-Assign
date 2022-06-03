const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Token", function () {
  it("tests token contract", async function () {
    const [admin,buyer] = await ethers.getSigners();
    const Token = await ethers.getContractFactory("Token");
   const TokenSale=await ethers.getContractFactory("TokenSale");

   const token=await Token.deploy();
    await token.deployed();

    const tokenSale=await TokenSale.deploy(token.address);
    await tokenSale.deployed();

    expect(await token.balanceOf(admin.address)).to.equal(100000);
    expect(await token.totalSupply()).to.equal(100000);
    expect(await tokenSale.tokenPrice()).to.equal(1000000000000000);
    expect(await tokenSale.getTokenSupply()).to.equal(100000);

    await token.transfer(tokenSale.address,10000);
   
    // console.log(await tokenSale.connect(admin).addToWhitelist(buyer.address));
    expect(await token.balanceOf(tokenSale.address)).to.equal(10000);
    expect(await token.balanceOf(buyer.address)).to.equal(0);
    expect(await token.balanceOf(admin.address)).to.equal(90000);
    expect( await tokenSale.connect(admin).addToWhitelist(buyer.address));
    // await expect(tokenSale.connect(admin).buyToken(11000)).to.be.revertedWith("Not enough tokens");
   
    await tokenSale.connect(admin).buyToken(1000,{value:ethers.utils.parseEther('1')});
    expect(await token.balanceOf(buyer.address)).to.equal(1000);
    console.log("contract balance :",await token.balanceOf(tokenSale.address));
    console.log("admin balance :",await token.balanceOf(admin.address));
    console.log("buyer balance :",await token.balanceOf(buyer.address));
   
  expect(await token.connect(admin).burn(buyer.address,100));
  expect(await token.balanceOf(buyer.address)).to.equal(900);

  });
});
