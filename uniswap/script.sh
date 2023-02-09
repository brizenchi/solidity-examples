source .env

ganache-cli \
--networkId 999 \
--fork https://mainnet.infura.io/v3/244764827dea471eb1b92257449c64f4


npm install @openzeppelin/contracts
npm install bn.js


npx truffle test --network mainnet_fork test/test-uniswap.js