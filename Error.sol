// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract FarmerMarketplace {
    address public marketplaceOwner;

    struct Product {
        string name;
        uint price; // Price can still be displayed, but it won't require Ether
        uint quantity;
        address farmer;
        bool exists;
    }

    mapping(uint => Product) public products;
    uint public productCount;

    event ProductAdded(uint productId, string name, uint price, uint quantity);
    event ProductBought(uint productId, address buyer, uint quantity);
    event ProductUpdated(uint productId, uint newPrice, uint newQuantity);

    modifier onlyFarmer(uint productId) {
        require(products[productId].farmer == msg.sender, "Only the farmer can modify this product");
        _;
    }

    constructor() {
        marketplaceOwner = msg.sender;
    }

    // Farmer adds a product to the marketplace
    function addProduct(string memory _name, uint _price, uint _quantity) public {
        require(_price > 0, "Price must be greater than zero");
        require(_quantity > 0, "Quantity must be greater than zero");

        productCount++;
        products[productCount] = Product({
            name: _name,
            price: _price,
            quantity: _quantity,
            farmer: msg.sender,
            exists: true
        });

        emit ProductAdded(productCount, _name, _price, _quantity);
    }

    // Buyer purchases a product (no Ether involved)
    function buyProduct(uint _productId, uint _quantity) public {
        Product storage product = products[_productId];
        require(product.exists, "Product does not exist");
        require(_quantity <= product.quantity, "Not enough quantity available");

        // Revert if quantity requested is zero
        if (_quantity == 0) {
            revert("Quantity must be greater than zero");
        }

        // Reduce the product quantity by the amount purchased
        product.quantity -= _quantity;

        emit ProductBought(_productId, msg.sender, _quantity);
    }

    // Farmer updates the product's price and quantity
    function updateProduct(uint _productId, uint _newPrice, uint _newQuantity) public onlyFarmer(_productId) {
        require(_newPrice > 0, "Price must be greater than zero");
        require(_newQuantity > 0, "Quantity must be greater than zero");

        Product storage product = products[_productId];
        product.price = _newPrice;
        product.quantity = _newQuantity;

        emit ProductUpdated(_productId, _newPrice, _newQuantity);
    }

    // Assertion to check product exists and has correct ownership
    function checkProductOwnership(uint _productId) public view returns (bool) {
        Product storage product = products[_productId];
        assert(product.exists && product.farmer == msg.sender); // Ensures farmer owns the product

        return true;
    }

    // Function to remove product using revert if the caller is not the farmer
    function removeProduct(uint _productId) public onlyFarmer(_productId) {
        Product storage product = products[_productId];

        if (product.quantity != 0) {
            revert("Cannot remove a product that still has quantity left");
        }

        delete products[_productId];
    }
}
