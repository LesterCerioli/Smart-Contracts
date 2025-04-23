const PatientRegistry = artifacts.require("PatientRegistry");

contract("PatientRegistry", (accounts) => {
  let registry;
  const admin = accounts[0];
  const nonAdmin = accounts[1];

  before(async () => {
    registry = await PatientRegistry.new({ from: admin });
  });

  it("should register a new patient", async () => {
    const allergies = ["Penicillin", "Peanuts"];
    const medications = ["Insulin", "Metformin"];
    const result = await registry.registerPatient(
      "John Doe",
      35,
      "Male",
      "O+",
      allergies,
      medications,
      { from: admin }
    );
    
    const patient = await registry.getPatient(1);
    assert.equal(patient.name, "John Doe");
    assert.equal(patient.age, 35);
  });

  it("should prevent non-admin from registering patients", async () => {
    try {
      await registry.registerPatient(
        "Jane Smith",
        28,
        "Female",
        "A-",
        [],
        [],
        { from: nonAdmin }
      );
      assert.fail("Should have thrown error");
    } catch (error) {
      assert.include(error.message, "Only admin can perform this action");
    }
  });

  it("should update patient information", async () => {
    const newAllergies = ["Latex"];
    await registry.updatePatient(
      1,
      "John Doe Updated",
      36,
      "Male",
      "O+",
      newAllergies,
      ["Insulin"],
      { from: admin }
    );
    
    const patient = await registry.getPatient(1);
    assert.equal(patient.name, "John Doe Updated");
    assert.equal(patient.age, 36);
    assert.equal(patient.allergies.length, 1);
  });
});