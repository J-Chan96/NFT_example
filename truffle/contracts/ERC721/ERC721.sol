// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "./IERC721.sol";
import "./IERC721Metadata.sol";


// public   : 
// private  :
// external : 본인컨트렉트 서로 공유가안됨 외부끼리만됨. 
// internal : 본인컨트렉트 에서만됨 즉 외부는안됨. 


contract ERC721 is IERC721, IERC721Metadata{

    string public override name;
    string public override symbol;

    mapping(address => uint) private _balances;
    mapping(uint => address) private _owners;
    mapping(uint => address) private _tokenApprovals;
    mapping(address=> mapping(address=> bool)) private _operatorApprovals;
    


    constructor(string memory _name, string memory _symbol){
        name = _name;
        symbol = _symbol;
    }

    function balanceOf(address _owner) public override view returns(uint) {
        require(_owner != address(0), "ERC721 : balance query for the zero address");
        return _balances[_owner];
    }

    function ownerOf(uint _tokenId) public override view returns(address) {
        address owner = _owners[_tokenId];
        require(owner != address(0), "ERC721 : owner query for nonexistent token.");
        return owner;
    }

    function approve(address _to, uint _tokenId) external override {
        address owner = ownerOf(_tokenId);
        require(_to != owner, "ERC 721 : approval to current owner");
        require(msg.sender == owner || isApprovedForAll(owner, msg.sender));
        
        _tokenApprovals[_tokenId] = _to;
        emit Approval(owner, _to, _tokenId);
        
    }

    
    function getApproved(uint _tokenId) public override view returns(address) {
        require(ownerOf(_tokenId) != address(0), "ERC721 : "); // tokenId가 실제 소유자가 있는가. 
        return _tokenApprovals[_tokenId]; // tokenId를 위임받은 대리인 주소
    }

    // msg.sender , _operator 모든 tokenId 사용을 허락하겠다. true , false 
    function setApprovalForAll(address _operator, bool _approved) external override {
        require(msg.sender != _operator);
        _operatorApprovals[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender, _operator, _approved);
    }

    // 내가 msg.sender 동훈  _operator => true , false
    function isApprovedForAll(address _owner, address _operator) public override view returns(bool) {
        return _operatorApprovals[_owner][_operator];
    }


    function _isApprovedOrOwner(address _spender, uint _tokenId) private view returns(bool)  {
        address owner = ownerOf(_tokenId);
        require(owner != address(0));
        return (_spender == owner || isApprovedForAll(owner, _spender) ||  getApproved(_tokenId) == _spender);
    }

    // from A , 대리인 2가지 본인, 대리인,
    function transferFrom(address _from, address _to, uint _tokenId) external override {
        require(_isApprovedOrOwner(_from, _tokenId));
        require(_from != _to);

        _afterToken(_from, _to, _tokenId );

        _balances[_from] -= 1;
        _balances[_to] += 1;
        _owners[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);
    }

    function tokenURI(uint256 _tokenId) external override virtual view returns (string memory) {}

    // mint 
    // 10개 1~10
    // 10
    function _mint(address _to, uint _tokenId) public {
        require(_to != address(0));
        address owner = _owners[_tokenId];
        require(owner == address(0));
        _afterToken(address(0), _to, _tokenId );
        _balances[_to] += 1;
        _owners[_tokenId] = _to;

        emit Transfer(address(0), _to, _tokenId);
    }

    function _afterToken(address _from, address _to, uint _tokenId) internal virtual {}
}