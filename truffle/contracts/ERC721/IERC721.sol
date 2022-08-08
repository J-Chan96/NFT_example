// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

interface IERC721 {
    // Event
    event Transfer(address indexed _from, address indexed _to, uint indexed _tokenId);
    event Approval(address indexed _from, address indexed _approved, uint indexed _tokenId);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
    // operator : 대리인
    // true : A -> B  == A가 B에게 토큰을 모두 주는 것
    // false :모든 토큰을 맡기는 것을 취소

    // Function
    // Owner가 가지고있는 총 NFT 갯수
    function balanceOf(address _owner) external view returns(uint);

    // _tokenId를 인자값으로 받고 -> tokenId를 소유하고 있는 address를 나타냄
    function ownerOf(uint _tokenId) external view returns(address);

    // transfer
    function transferFrom(address _from, address _to, uint _tokenId) external; // external 이 함수를 외부에서 사용하겠다. 여기있는 컨트랙트가 아닌
 
    // approve 대리인 : 토큰하나에 대한 대리인
    function approve(address _to, uint _tokenId) external;
    function getApproved(uint _tokenId) external view returns(address); // return을 했을 때 tokenId의 대리인이 누구인지 알아내는 함수이다

    // setApprovalForAll 대리인 : owner가 가진 모든토큰에 대한 대리인 지정 권한 -> true, false
    function setApprovalForAll(address _operator, bool _approved) external;
    
    // _approved를 return해주는 함수 --> 대리인이 true냐 false냐를 검증해주는 함수
    function isApprovedForAll(address _owner, address _operator) external view returns(bool);
}