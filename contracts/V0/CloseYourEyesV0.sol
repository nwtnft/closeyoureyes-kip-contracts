// SPDX-License-Identifier: MIT

pragma solidity 0.5.6;

import "../utils/Strings.sol";
import "../klaytn-contracts/token/KIP17/KIP17Full.sol";
import "../klaytn-contracts/token/KIP17/KIP17Mintable.sol";
import "../klaytn-contracts/token/KIP17/KIP17MetadataMintable.sol";
import "../klaytn-contracts/token/KIP17/KIP17Burnable.sol";
import "../klaytn-contracts/drafts/Counters.sol";
import "../klaytn-contracts/ownership/Ownable.sol";

contract CloseYourEyesV0 is KIP17Full, KIP17Mintable, KIP17MetadataMintable, KIP17Burnable, Ownable {
	using Strings for uint256;

	string TOKEN_NAME = "CYE ChuchuCAT V0";
	string TOKEN_SYMBOL = "CYECV0";
	uint256 MAX_NFT_SUPPLY = 8888;
	string private _baseTokenURI;

	address public minterContract;
	address public devAddress;

	Counters.Counter private _tokenIdTracker;

	modifier onlyMinter() {
		require(totalSupply() < MAX_NFT_SUPPLY);
		require(msg.sender == minterContract);
		_;
	}

	modifier onlyDev() {
		require(msg.sender == devAddress);
		_;
	}

	constructor(address _dev, string memory _baseuri) public KIP17Full(TOKEN_NAME, TOKEN_SYMBOL) {
		_baseTokenURI = _baseuri;
		_tokenIdTracker.increment();
		setDevAddress(_dev);
	}

	function mint(address to) public onlyMinter returns (bool) {
		require(totalSupply() < MAX_NFT_SUPPLY, "Mint end.");
		_mint(to, _tokenIdTracker.current());
		_tokenIdTracker.increment();
		return true;
	}

	function setMinterContract(address saleContract) public onlyDev {
		minterContract = saleContract;
	}

	function setDevAddress(address _devAddress) public onlyOwner {
		devAddress = _devAddress;
	}

	function tokenURI(uint256 tokenId) public view returns (string memory) {
		require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

		string memory baseURI = _baseURI();
		return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString())) : "";
	}

	function setBaseURI(string memory baseURI) public onlyDev {
		_baseTokenURI = baseURI;
	}

	function getBaseURI() public view returns (string memory) {
		return _baseURI();
	}

	function _baseURI() internal view returns (string memory) {
		return _baseTokenURI;
	}
}
