# Eth-Avax-Mod1
# Farmer Marketplace Smart Contract

## Overview
The **Farmer Marketplace** smart contract allows farmers to list products for sale, and buyers to purchase them. The marketplace supports basic functionalities such as adding, updating, and purchasing products. The smart contract ensures that only the farmer who listed a product can modify it, and products are bought without the use of Ether, focusing more on product listing and quantity tracking.

## Features
- **Product Listing by Farmers**: Farmers can add products with a name, price, and quantity to the marketplace.
- **Product Purchase**: Buyers can purchase products listed by farmers, which decreases the available quantity of the product.
- **Product Update**: Farmers can update the price and quantity of their own products.
- **Access Control**: Only the farmer who added a product can update it.

## Contract Details

### State Variables
- `address public marketplaceOwner`: The address of the contract owner (deployer).
- `mapping(uint => Product) public products`: A mapping to store products listed by farmers.
- `uint public productCount`: Tracks the total number of products listed.

### Structs
- **Product**:
  - `string name`: Name of the product.
  - `uint price`: Price of the product.
  - `uint quantity`: Available quantity of the product.
  - `address farmer`: Address of the farmer who added the product.
  - `bool exists`: A boolean to check if the product exists.

### Events
- **`ProductAdded`**: Emitted when a farmer adds a new product.
  - Parameters: `productId`, `name`, `price`, `quantity`.
- **`ProductBought`**: Emitted when a buyer purchases a product.
  - Parameters: `productId`, `buyer`, `quantity`.
- **`ProductUpdated`**: Emitted when a farmer updates the price or quantity of their product.
  - Parameters: `productId`, `newPrice`, `newQuantity`.

### Modifiers
- **`onlyFarmer(uint productId)`**: Ensures that only the farmer who added the product can modify it.

## Functions

### `constructor()`
- Initializes the contract by setting the `marketplaceOwner` to the contract deployer's address.

### `addProduct(string memory _name, uint _price, uint _quantity)`
- Allows a farmer to add a product to the marketplace.
- Emits a `ProductAdded` event upon successful addition.

### `buyProduct(uint _productId, uint _quantity)`
- Allows a buyer to purchase a product by specifying its ID and quantity.
- Updates the product's available quantity.
- Emits a `ProductBought` event upon successful purchase.

### `updateProduct(uint _productId, uint _newPrice, uint _newQuantity)`
- Allows a farmer to update the price and quantity of their product.
- Only the farmer who added the product can perform this operation.
- Emits a `ProductUpdated` event upon successful update.

## How to Use

1. **Deploying the Contract**:
   - The contract is deployed by calling the constructor, which sets the marketplace owner.

2. **Adding Products**:
   - Farmers can call the `addProduct()` function to list a new product by providing a name, price, and quantity.

3. **Buying Products**:
   - Buyers can purchase products by calling the `buyProduct()` function and providing the product ID and the desired quantity.

4. **Updating Products**:
   - Farmers can update the details (price and quantity) of a product they've listed by calling the `updateProduct()` function with the product ID and new values.

## Considerations
- The contract does not involve Ether for transactions; it's designed for tracking products and their quantities.
- Access control is in place to prevent unauthorized updates to products.

## License
This project is licensed under the MIT License.
