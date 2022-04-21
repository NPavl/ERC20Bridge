// SPDX-License-Identifier: Unlicense
pragma solidity >=0.4.22 <0.9.0;

import "./Token.sol";
// import './Itoken.sol';
// import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/utils/cryptography/SignatureChecker.sol"; // наследует ECDSA.sol

contract bridgeBase is Ownable {
    using Counters for Counters.Counter;
    Token public token; // 0x87D7245c500C76C77a1f12B58708CFcfCCE4A19C with ERC20Burnable.sol
    // IToken public token;
    enum Step {
        Swap,
        Redeem
    }
    // uint256 private chainId;
    address private validator;
    mapping(address => mapping(uint256 => bool)) public swapProcess;
    mapping(uint256 => bool) chains;
    mapping(string => address) tokens;
    mapping(bytes32 => bool) swaps;
    mapping(address => Counters.Counter) private _nonces;

    event SwapEvent(
        address sender,
        address recipient,
        uint256 nonce,
        uint256 amount,
        uint256 chainFrom,
        uint256 chainTo,
        string _symbol,
        bytes signature,
        Step indexed step
    );
    event RedeemEvent(
        address sender,
        address recipient,
        uint256 nonce,
        uint256 amount,
        uint256 chainFrom,
        uint256 chainTo,
        string _symbol,
        bytes signature,
        Step indexed step
    );

    constructor(address _token, string memory _symbol) {
        token = Token(_token);
        // token = IToken(_token); //
        tokens[_symbol] = _token;
        // chainId = _chainId;
    }

    function includeToken(string calldata _symbol, address _token)
        external
        onlyOwner
    {
        tokens[_symbol] = _token;
    }

    function excludeToken(string calldata _symbol) external onlyOwner {
        tokens[_symbol] = address(0);
    }

    function checkTokenExist(string calldata _symbol)
        public
        view
        returns (address _token)
    {
        _token = tokens[_symbol];
        require(_token != address(0), "token not exist");
        return _token;
    }

    function swap(
        address signer,
        address _recepient,
        uint256 _amount,
        uint256 _chainTo,
        string memory _symbol,
        bytes calldata signature
    ) public {
        uint256 nonce = _nonces[msg.sender].current();
        require(
            swapProcess[msg.sender][nonce] == false,
            "transfer already processed"
        );
        swapProcess[msg.sender][nonce] = true;
        require(
            tokens[_symbol] != address(0),
            "the token was not added to the bridge"
        );
        uint256 _chainFrom;
        assembly {
            _chainFrom := chainid() // chainid https://ethereum.stackexchange.com/questions/56749/retrieve-chain-id-of-the-executing-chain-from-a-solidity-contract
        }
        require(
            _chainTo != _chainFrom,
            "Error: chainTo and chainFrom is the same"
        );

        bytes32 result = _hash(
            signer,
            _recepient,
            nonce,
            _amount,
            _chainFrom,
            _chainTo,
            _symbol
        );

        // token.burn(msg.sender, _amount);
        Token(tokens[_symbol]).burnFrom(msg.sender, _amount); // для списания необходимо вызывать approve в кол-ве amount spender адрес контракта моста
        swaps[result] = true;
        _nonces[msg.sender].increment();

        emit SwapEvent(
            msg.sender,
            _recepient,
            nonce,
            _amount,
            _chainFrom,
            _chainTo,
            _symbol,
            signature,
            Step.Swap
        );
    }

    function redeem(
        address _signer,
        address _recepient,
        uint256 _amount,
        uint256 _chainFrom,
        uint256 _chainTo,
        string memory _symbol,
        bytes calldata signature
    ) external {
        uint256 nonce = _nonces[msg.sender].current();
        require(
            swapProcess[msg.sender][nonce] == false,
            "transfer already processed"
        );
        swapProcess[msg.sender][nonce] = true;
        require(
            _verify(
                _signer,
                _hash(
                    _signer,
                    _recepient,
                    nonce,
                    _amount,
                    _chainFrom,
                    _chainTo,
                    _symbol
                ),
                signature
            ),
            "Invalid signature"
        );

        // redeemNonces[account][nonce] = true;
        // token.mint(_recepient, _amount);
        Token(tokens[_symbol]).mint(_recepient, _amount);

        emit RedeemEvent(
            msg.sender,
            _recepient,
            nonce,
            _amount,
            _chainFrom,
            _chainTo,
            _symbol,
            signature,
            Step.Redeem
        );
    }

    function _hash(
        address _signer,
        address _recepient,
        uint256 _nonce,
        uint256 _amount,
        uint256 _chainFrom,
        uint256 _chainTo,
        string memory _symbol
    ) internal pure returns (bytes32) {
        return
            ECDSA.toEthSignedMessageHash(
                keccak256(
                    abi.encodePacked(
                        _signer,
                        _recepient,
                        _nonce,
                        _amount,
                        _chainFrom,
                        _chainTo,
                        _symbol
                    )
                )
            );
    }

    function _verify(
        address signer,
        bytes32 hash,
        bytes memory signature
    ) internal view returns (bool) {
        // address recoveredAddress = ECDSA.recover(digest, signature);
        return SignatureChecker.isValidSignatureNow(signer, hash, signature);

        //     if (signer == validator) {
        //         return true;
        //     } else {
        //         return false;
        //     }
    }
}
