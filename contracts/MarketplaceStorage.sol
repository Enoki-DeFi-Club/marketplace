pragma solidity ^0.4.24;

import "./interfaces/IERC20.sol";
import "./interfaces/IERC721.sol";

contract ERC721Verifiable is ERC721Interface {
  function verifyFingerprint(uint256, bytes) public view returns (bool);
}


contract MarketplaceStorage {
  ERC20Interface public acceptedToken;

  struct Order {
    // Order ID
    bytes32 id;
    // Owner of the NFT
    address seller;
    // NFT registry address
    address nftAddress;
    // Price (in wei) for the published item
    uint256 price;
    // Time when this sale ends
    uint256 expiresAt;
  }

  // From ERC721 registry assetId to Order (to avoid asset collision)
  mapping (address => mapping(uint256 => Order)) public orderByAssetId;

  uint256 public ownerCutPerMillion;
  uint256 public publicationFeeInWei;

  address public legacyNFTAddress;

  bytes4 public constant InterfaceId_ValidateFingerprint = bytes4(
    keccak256("verifyFingerprint(uint256,bytes)")
  );

  bytes4 public constant ERC721_Interface = bytes4(0x80ac58cd);

  // EVENTS
  event OrderCreated(
    bytes32 id,
    uint256 indexed assetId,
    address indexed seller,
    address nftAddress,
    uint256 priceInWei,
    uint256 expiresAt
  );
  event OrderSuccessful(
    bytes32 id,
    uint256 indexed assetId,
    address indexed seller,
    address nftAddress,
    uint256 totalPrice,
    address indexed buyer
  );
  event OrderCancelled(
    bytes32 id,
    uint256 indexed assetId,
    address indexed seller,
    address nftAddress
  );

  event ChangedPublicationFee(uint256 publicationFee);
  event ChangedOwnerCutPerMillion(uint256 ownerCutPerMillion);
  event ChangeLegacyNFTAddress(address indexed legacyNFTAddress);

  // [LEGACY] Auction events
  event AuctionCreated(
    bytes32 id,
    uint256 indexed assetId,
    address indexed seller,
    uint256 priceInWei,
    uint256 expiresAt
  );
  event AuctionSuccessful(
    bytes32 id,
    uint256 indexed assetId,
    address indexed seller,
    uint256 totalPrice,
    address indexed winner
  );
  event AuctionCancelled(
    bytes32 id,
    uint256 indexed assetId,
    address indexed seller
  );
}