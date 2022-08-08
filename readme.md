# Mingting

NFT

NFT -> 민팅, 판매, 구매 스마트 컨트랙트
Next로 화면을 구현

DID - Decentralized Identifier
: 공인인증서를 탈중앙화에 넣는다.
신분증 사원증 졸업증명서

# NFT

ERC-20 / Token fungible Token
ERC-721 / Token Non-fungible Token(NFT)

ex)
ChanToken이 1000개 있다.
여기서 Token 하나당 가격은 동일하다 -> 토큰을 수량으로 값어치는 측정한다.

NFT는 총 1000장이 있다고 가정한다면, 그 하나하나의 의미가 다르다.

NFT는 코드로 구현할려면 어캐함?

erc-20
mint(msg.sender, 100000)

erc-721
primary key
mint(msg.sender,1) ==> 여기서 1의 의미는 수량에 대한 의미가 아닌 1번에 대한 토큰을 만들겠다라는 의미이다.
mint(msg.sender,2)
mint(msg.sender,3)
mint(msg.sender,4)

mapping(address => uint) public balances;
0x1234 => 2000 // 총 2000개 토큰있다. 여기서 uint는 수량이 아닌 고유한 키값을 말함 총 2000개의 토큰을 가지고있다.
-> 1번~2000번의 토큰이 있다. 같은 내용의 토큰이 아닌!

mapping(uint => address) public owned;

NFT는 하나의 토큰 값마다 키값이 다 다르다. 일련번호가 다르다고 생각하는게 좋을듯?

OpenSea NFT 마켓

- OpenSea NFT
- Smart Contract

```
mkdir truffle
cd truffle
truffle init

npm install -g @remix-project/remixd
cd contracts

터미널에서
remixd -s . --remix-ide https://remix.ethereum.org
```

# NFT

ERC20 -> 라이브러리
라이브러리 먼저 만들어보고
직접구현

```
터미널 새로 열고
cd truffle
npm init -y
npm install openzeppelin-solidity
```

//
opensea 테스트넷
testnets.opensea.io

https://eips.ethereum.org/EIPS/eip-721
