
pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol";
import "./Structs.sol";

contract ExternalStorage is Ownable {
  using SafeMath for uint256;

  function ExternalStorage () public {
    setUIntValue('ratingIdCounter', 0);
  }

  mapping(address => mapping(bytes32 => Structs.Rating)) public ratings;

  function getRating(address sender, bytes32 txHash) public view onlyOwner returns (Structs.Rating) {
    return ratings[sender][txHash];
  }

  function setRating(address sender, bytes32 txHash, Structs.Rating rating) public onlyOwner {
    ratings[sender][txHash] = rating;    
  }

  mapping(bytes32 => uint256) UIntStorage;

  function getUIntValue(string record) public view onlyOwner returns (uint256) {
    return UIntStorage[keccak256(record)];
  }

  function setUIntValue(string record, uint256 value) public onlyOwner {
    UIntStorage[keccak256(record)] = value;
  }

  mapping(bytes32 => bytes32) Bytes32Storage;

  function getBytes32Value(string record) public view onlyOwner returns (bytes32) {
    return Bytes32Storage[keccak256(record)];
  }

  function setBytes32Value(string record, bytes32 value) public onlyOwner {
    Bytes32Storage[keccak256(record)] = value;
  }

  mapping(bytes32 => address) AddressStorage;

  function getAddressValue(string record) public view onlyOwner returns (address) {
    return AddressStorage[keccak256(record)];
  }

  function setAddressValue(string record, address value) public {
    AddressStorage[keccak256(record)] = value;
  }

  mapping(bytes32 => bytes) BytesStorage;

  function getBytesValue(string record) public view onlyOwner returns (bytes) {
    return BytesStorage[keccak256(record)];
  }

  function setBytesValue(string record, bytes value) public onlyOwner {
    BytesStorage[keccak256(record)] = value;
  }

  mapping(bytes32 => bool) BooleanStorage;

  function getBooleanValue(string record) public view onlyOwner returns (bool) {
    return BooleanStorage[keccak256(record)];
  }

  function setBooleanValue(string record, bool value) public onlyOwner {
    BooleanStorage[keccak256(record)] = value;
  }

  mapping(bytes32 => int) IntStorage;

  function getIntValue(string record) public view onlyOwner returns (int) {
    return IntStorage[keccak256(record)];
  }

  function setIntValue(string record, int value) public onlyOwner {
    IntStorage[keccak256(record)] = value;
  }
}
