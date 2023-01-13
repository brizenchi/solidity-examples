// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
/*
1. message to sign
2. hash(message)
3. sign(hash(message), privatekey) | offchain
4. ecrecover(hash(message), signature) == publickey


使用
1. 调用 getMessageHash("12sddsdwe")  get 0xa53a39ae54a5b6976bb757b71e58e0873fa9b75c0dd4118e482ec043de7a8cf0

2. 链下签名
ethereum.enable()
account="0xd58de57dA810d2e6C78fE3E037263aEDEf4CEbFc"
hash="0xa53a39ae54a5b6976bb757b71e58e0873fa9b75c0dd4118e482ec043de7a8cf0"
ethereum.request({method:"personal_sign", params:[account, hash]})   
get 0xa8c93ed799c47ba29677ee376b03c79b67757faaa7677282413862a5eab04ab46430e84b9cd39c42d384c6acf5607e62a20411daa18e1f7729a52b7e97f915dd1b

3. 调用 getETHSignedMessageHash("0xa53a39ae54a5b6976bb757b71e58e0873fa9b75c0dd4118e482ec043de7a8cf0")  
    get 0x9acbf6ecb42c31e6c8f979cfc55843471099fbb283382eb2c290bf55559f35ce

4. recover("0x93444cefb5621f42c7ba1a974247b34b8ad720dca7b92ac95302ddbbf71cd551", 
"0xa8c93ed799c47ba29677ee376b03c79b67757faaa7677282413862a5eab04ab46430e84b9cd39c42d384c6acf5607e62a20411daa18e1f7729a52b7e97f915dd1b") = 
get 0xd58de57dA810d2e6C78fE3E037263aEDEf4CEbFc


*/
contract verifySig {
    // 签名人地址，信息原文，签名结果
    function verify(address _signer, string memory _message, bytes memory _sig) 
        external pure returns (bool) {
        bytes32 messageHash = getMessageHash(_message); // hash
        bytes32 ethSignedmessageHash = getETHSignedMessageHash(messageHash); // 再次hash
        return recover(ethSignedmessageHash, _sig) == _signer; // 
    }

    function getMessageHash(string memory _message) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_message));
    }
    function getETHSignedMessageHash(bytes32 _messagehash) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(
            "\x19Ethereum Signed Message:\n32", // 链下签名需要
            _messagehash));
    }
    function recover(bytes32 _messagehash, bytes memory _sig) public pure returns (address) {
        (bytes32 r, bytes32 s, uint8 v) = _split(_sig);
        return ecrecover(_messagehash, v, r,s);
    }
    function _split(bytes memory _sig) internal pure returns (bytes32 r, bytes32 s, uint8 v) {
        require(_sig.length == 65, "invalid");
        // r 占用前32位
        // s 后32位
        // uint8 最后1位
        assembly {
            r := mload(add(_sig, 32))
            s := mload(add(_sig, 64))
            v := byte(0, mload(add(_sig, 96)))
        }
    }
 }
