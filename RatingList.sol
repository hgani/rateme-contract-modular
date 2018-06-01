pragma solidity ^0.4.18;

import "./Structs.sol";
import "./ExternalStorage.sol";

contract RatingList {  
  ExternalStorage public _storage;

  function RatingList(address storageAddress) public {
    _storage = ExternalStorage(storageAddress);
  }
  
  function rate(string txHash, uint stars, string review) public {
    bytes32 key = keccak256(txHash);
    Structs.Rating memory rating = _storage.getRating(msg.sender, key);
    
    require(stars >= 1 && stars <= 10);
    require(bytes(review).length <= 5000);
    
    uint ratingIdCounter = _storage.getUIntValue("ratingIdCounter") + 1;
    _storage.setUIntValue("ratingIdCounter",  ratingIdCounter);

    rating.id = ratingIdCounter; 
    rating.stars = min(stars, 10);
    rating.review = review;
  }
  
  function getRating(address sender, string txHash) view public returns (uint id, uint stars, string review) {
    bytes32 key = keccak256(txHash);
    Structs.Rating memory rating = _storage.getRating(sender, key);
    
    id = rating.id;
    stars = rating.stars;
    review = rating.review;
  }

  function min(uint a, uint b) pure public returns (uint _min) {
    if (a > b)
        return b;
    else
        return a;
  }
  
  function divCeil(uint a, uint b) pure public returns (uint result) {
    result = a / b;
    if ((result * b) < a) {
      result++;
    }
  }
}