source .env

ganache-cli \
--networkId 999 \
--fork https://celo-mainnet.infura.io/v3/c0a66f38237d4553af849a40e689f792 \
--unlock $DAI_WHALE


npm install @openzeppelin/contracts
npm install bn.js


npx truffle test --network mainnet_fork test/test-uniswap.js

