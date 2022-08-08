// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

import "./ERC721.sol";

contract ERC721Enumerable is ERC721 {
    uint[] private _allTokens;

                            // index => tokenId
    mapping(address => mapping(uint => uint)) private _ownedTokens;

    // tokenId => index
    mapping(uint => uint) private _ownedTokenIndex;

    constructor(string memory _name, string memory _symbol) ERC721(_name,_symbol){}

    function mint(address _to) public {
        _mint(_to, _allTokens.length);
        // _allTokens.push(_allTokens.length);
    }

    function _afterToken(address _from, address _to, uint _tokenId) internal override {
        // mint 함수를 실행했을 경우
        if(_from == address(0)) {
            _allTokens.push(_allTokens.length);
            // [0x1234][0] = 0
            // 0x1234 , 1
            // 0x1234 , 2
           
         // transferFrom이 실행됬을 경우
        } else {
            // 1 : 6, 2 : 6  1번 account에서 6번 TokenId를 2번 account에 보낼 것이다.
            uint latestTokenIndex = ERC721.balanceOf(_from) -1; // 1번 account에서 마지막 인덱스의 값(토큰값)을 구해야함 4
            uint tokenIndex = _ownedTokenIndex[_tokenId]; // 6번 TokenId의 인덱스값을 가져옴 3

            if(tokenIndex != latestTokenIndex){
                uint latestTokenId = _ownedTokens[_from][latestTokenIndex]; // 3
                
                _ownedTokens[_from][tokenIndex] = latestTokenId; // 0:3
                _ownedTokenIndex[latestTokenId] = tokenIndex; // 0
            }

            delete _ownedTokens[_from][latestTokenIndex]; // 3:3
            delete _ownedTokenIndex[_tokenId]; // 0:0

        }

         uint length = ERC721.balanceOf(_to); // 3
        _ownedTokens[_to][length] = _tokenId;
        _ownedTokenIndex[_tokenId] = length;
    }

    function _totalSupply() public view returns(uint) {
        return _allTokens.length;
    }

    function tokenByIndex(uint _index) public view returns (uint) {
        require(_index < _allTokens.length);
        return _allTokens[_index];
    }

    function tokenOfOwnerByIndex(address _owner, uint _index) public view returns(uint) {
        require(_index < ERC721.balanceOf(_owner));
        return _ownedTokens[_owner][_index];
    }
}

/**
    내 NFT목록을 볼수있는 기능
    tokenId 자동생성을 위한 totalSupply();

    mapping(address => mapping(uint => uint)) ownedTokens; 1. uint 순서 2. uint tokenId


    ownedTokens
    {
        0x1234: {
            0:3,
            1:1,
            2:2,
        },
        0x1111: {
            0:4,
            1:5,
            2:6,
            3:0
        }
    }

    ownedTokenIndex
    {
        "1":1,
        "2":2,
        "0":3
        "0":4
        "1":5
        "2":6
        "3":0
    }




    



 */