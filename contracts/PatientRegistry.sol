// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PatientRegistry {
    struct Patient {
        uint256 id;
        string name;
        uint256 age;
        string gender;
        string bloodType;
        string[] allergies;
        string[] medications;
        uint256 registrationDate;
        address registeredBy;
    }

    mapping(uint256 => Patient) private patients;
    uint256 private patientCount;
    address private admin;

    event PatientRegistered(uint256 indexed patientId, address indexed registeredBy);
    event PatientUpdated(uint256 indexed patientId);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function registerPatient(
        string memory _name,
        uint256 _age,
        string memory _gender,
        string memory _bloodType,
        string[] memory _allergies,
        string[] memory _medications
    ) public onlyAdmin returns (uint256) {
        patientCount++;
        
        patients[patientCount] = Patient({
            id: patientCount,
            name: _name,
            age: _age,
            gender: _gender,
            bloodType: _bloodType,
            allergies: _allergies,
            medications: _medications,
            registrationDate: block.timestamp,
            registeredBy: msg.sender
        });

        emit PatientRegistered(patientCount, msg.sender);
        return patientCount;
    }

    function updatePatient(
        uint256 _patientId,
        string memory _name,
        uint256 _age,
        string memory _gender,
        string memory _bloodType,
        string[] memory _allergies,
        string[] memory _medications
    ) public onlyAdmin {
        require(_patientId <= patientCount && _patientId > 0, "Invalid patient ID");
        
        Patient storage patient = patients[_patientId];
        patient.name = _name;
        patient.age = _age;
        patient.gender = _gender;
        patient.bloodType = _bloodType;
        patient.allergies = _allergies;
        patient.medications = _medications;

        emit PatientUpdated(_patientId);
    }

    function getPatient(uint256 _patientId) public view returns (
        uint256 id,
        string memory name,
        uint256 age,
        string memory gender,
        string memory bloodType,
        string[] memory allergies,
        string[] memory medications,
        uint256 registrationDate,
        address registeredBy
    ) {
        require(_patientId <= patientCount && _patientId > 0, "Invalid patient ID");
        
        Patient storage patient = patients[_patientId];
        return (
            patient.id,
            patient.name,
            patient.age,
            patient.gender,
            patient.bloodType,
            patient.allergies,
            patient.medications,
            patient.registrationDate,
            patient.registeredBy
        );
    }

    function getPatientCount() public view returns (uint256) {
        return patientCount;
    }

    function transferAdmin(address _newAdmin) public onlyAdmin {
        require(_newAdmin != address(0), "Invalid address");
        admin = _newAdmin;
    }
}