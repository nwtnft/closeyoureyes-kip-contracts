// SPDX-License-Identifier: MIT

pragma solidity ^0.5.6;

interface ICloseYourEyesV0 {
	event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

	event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

	event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

	function mint(address to) external;

	function totalSupply() external view returns (uint256);

	function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256 tokenId);

	function tokenByIndex(uint256 index) external view returns (uint256);

	function balanceOf(address owner) external view returns (uint256 balance);

	function ownerOf(uint256 tokenId) external view returns (address owner);

	function transferFrom(
		address from,
		address to,
		uint256 tokenId
	) external;

	function approve(address to, uint256 tokenId) external;

	function getApproved(uint256 tokenId) external view returns (address operator);

	function setApprovalForAll(address operator, bool _approved) external;

	function isApprovedForAll(address owner, address operator) external view returns (bool);
}
