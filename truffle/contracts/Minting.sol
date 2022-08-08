// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.15;

// import "openzeppelin-solidity/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

// contract Minting is ERC721 {
//     constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) {} // ERC721 생성자 함수에 똑같이 2개의 인자값을 넣어줬다.

//     function _minting(uint _tokenId) public {
//         _mint(msg.sender, _tokenId); // ERC721안에 있는 _mint
//     }

//     function tokenURI(uint _tokenId) public override pure returns (string memory) {
//         return "https://gateway.pinata.cloud/ipfs/QmPwjnvWYN4etA5eW4yAbWCTy2ukEC1Jj5417VLGyH5XpU/1/1.json";
//     }

// }