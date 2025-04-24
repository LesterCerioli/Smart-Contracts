const CustomizedContract = artifacts.require("MyContract");

contract("MyContract", (accounts) => {
  it("should store and return a message", async () => {
    const instance = await CustomizedContract.deployed();
    await instance.setMessage("New message");
    const message = await instance.getMessage();
    assert.equal(message, "New message");
  });
});