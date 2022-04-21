### Description bridge task: 

Техническое задание(мост)

Написать контракт кроссчейн моста для отправки токенов стандарта ERC-20 между сетями Ethereum и Binance Smart chain.
- Написать контракт Bridge
- Написать полноценные тесты к контракту
- Написать скрипт деплоя
- Задеплоить в тестовую сеть
- Написать таск на swap, redeem
- Верифицировать контракт

Требования:
- Функция swap(): списывает токены с пользователя и испускает event ‘swapInitialized’
- Функция redeem(): вызывает функцию ecrecover и восстанавливает по хэшированному сообщению и сигнатуре адрес валидатора, 
  если адрес совпадает с адресом указанным на контракте моста то пользователю отправляются токены
- Функция updateChainById(): добавить блокчейн или удалить по его chainID
- Функция includeToken(): добавить токен для передачи его в другую сеть
- Функция excludeToken(): исключить токен для передачи


- пример (eattheblocks) : https://github.com/jklepatch/eattheblocks/tree/master/screencast/317-eth-bsc-decentralized-bridge
- https://www.youtube.com/watch?v=LFoTlG-4TmU
- how to build a decentralized token bridge between ethereum and binance smart chain
- https://medium.com/coinmonks/how-to-build-a-decentralized-token-bridge-between-ethereum-and-binance-smart-chain-58de17441259

#### Token contract address (Rinkiby): 	

- Bridge contract = ''

#### All packages:
```
yarn init 
yarn add --dev hardhat 
yarn add --dev @nomiclabs/hardhat-ethers ethers 
yarn add --dev @nomiclabs/hardhat-waffle ethereum-waffle chai
yarn add --save-dev @nomiclabs/hardhat-etherscan
yarn add install dotenv 
yarn add --dev solidity-coverage 
yarn add --dev hardhat-gas-reporter 
yarn add --dev hardhat-gas-reporter
yarn add --dev hardhat-contract-sizer
```
#### Main command:
```
npx hardhat 
npx hardhat run scripts/file-name.js
npx hardhat test 
npx hardhat coverage
npx hardhat run --network localhost scripts/deploy.js
npx hardhat run scripts/deploy.js --network rinkiby
npx hardhat verify <contract_address> --network rinkiby
npx hardhat verify --constructor-args scripts/arguments.js <contract_address> --network rinkiby
npx hardhat verify --constructor-args scripts/arguments.js <conract_address> --network rinkiby
yarn run hardhat size-contracts 
yarn run hardhat size-contracts --no-compile
```
### EIP's, ECDSA, Verifying Signature, Signing trаnsactions ... :

EIP's: 
```
- EIP-191: Signed Data Standard: https://eips.ethereum.org/EIPS/eip-191
- EIP-712: Cтандарт для хэширования и подписи типизированных структурированных данных: https://eips.ethereum.org/EIPS/eip-712
- eip-1271:  Стандартный метод проверки подписи для контрактов https://eips.ethereum.org/EIPS/eip-1271
- EIP-155: Простая защита от повторных атак https://eips.ethereum.org/EIPS/eip-155

```

- ECDSA (Elliptic Curve Digital Signature Algorithm - алгоритм с открытым ключом для создания цифровой подписи)
https://docs.openzeppelin.com/contracts/4.x/api/utils#ECDSA 

- Openzeppeline workshop: 
- How to use different cryptographic tools using ECDSA and ERC712 signatures, along with merkle-tree generation
(ECDSA.sol, ERC712.sol, AccessControl.sol, draft-EIP712.sol, SignatureChecker.sol, MerkleProof.sol, ) 
https://www.youtube.com/watch?v=SF-XOwWIwRo
https://github.com/OpenZeppelin/workshops/tree/master/06-nft-merkle-drop

Доп примеры openzeppelin-contracts/contracts/utils/cryptography/
https://github.com/OpenZeppelin/openzeppelin-contracts/tree/afb20119b33072da041c97ea717d3ce4417b5e01/contracts/utils/cryptography\
- utils/cryptography/ECDSA.sol
  https://github.com/OpenZeppelin/openzeppelin-contracts/blob/afb20119b33072da041c97ea717d3ce4417b5e01/contracts/utils/cryptography/ECDSA.sol
- utils/cryptography/SignatureChecker.sol
  https://github.com/OpenZeppelin/openzeppelin-contracts/blob/afb20119b33072da041c97ea717d3ce4417b5e01/contracts/utils/cryptography/SignatureChecker.sol
- ECDSAMock.sol
  https://github.com/OpenZeppelin/openzeppelin-contracts/blob/5b28259dacf47fc208e03611eb3ba8eeaed63cc0/contracts/mocks/ECDSAMock.sol

примеры для DAO governance with ECDSA:
https://github.com/OpenZeppelin/openzeppelin-contracts/blob/afb20119b33072da041c97ea717d3ce4417b5e01/contracts/token/ERC20/extensions/ERC20Votes.sol
https://github.com/OpenZeppelin/openzeppelin-contracts/blob/76eee35971c2541585e05cbf258510dda7b2fbc6/contracts/governance/Governor.sol
https://github.com/OpenZeppelin/openzeppelin-contracts/blob/f2a311dc4a5757ee8064769a603a715b05d359b3/contracts/governance/utils/Votes.sol

- Verifying Signature 
Messages can be signed off chain and then verified on chain using a smart contract
https://youtu.be/NP4db_UPVwc
https://solidity-by-example.org/signature/

- Signing Messages   
https://docs.ethers.io/v4/cookbook-signing.html?highlight=signmessage 

- Signing and Verifying Ethereum Signatures
https://yos.io/2018/11/16/ethereum-signatures/
 
- Sign and Verify messages with React.js and MetaMask 
 Простой и полезный пример как подписать сообщения в метамаске используя свой закрытый ключ, не взаимодействуя с блокчейном.
 Также можно проверить действительно ли то что владелец этого конкретного адреса сгенерировал данную подпись.
https://www.youtube.com/watch?v=vhUjCLYlnMM
https://codesandbox.io/s/ibuxj (хороший простой пример) 

- Signing Data with MetaMask (good sample) 
https://docs.metamask.io/guide/signing-data.html
- приложение (E2E Test Dapp) 
https://metamask.github.io/test-dapp/
- Login with MetaMask (пример как залогинистся с подписью с помощью метамаска)
https://github.com/amaurym/login-with-metamask-demo

- Подписание и проверка подписей Ethereum
https://www.codementor.io/@yosriady/signing-and-verifying-ethereum-signatures-vhe8ro3h6

- Signature Replay | Hack Solidity (0.6)
https://www.youtube.com/watch?v=jq1b-ZDRVDc
https://solidity-by-example.org/hacks/signature-replay/
Атака с повторным воспроизведением подписи. основная идея данной атаки в том то можно 
использовать одну и туже подпись для выполнени транзакции несколько раз... , как избежать такой атаки.

- безгазовые токены и разрешение ERC20
https://soliditydeveloper.com/erc20-permit
https://github.com/soliditylabs/ERC20-Permit/blob/main/contracts/ERC20Permit.sol

- EIP712 how to use it
https://medium.com/metamask/eip712-is-coming-what-to-expect-and-how-to-use-it-bb92fd1a7a26

- What is ecrecover in Solidity? -> https://soliditydeveloper.com/ecrecover/

- The Magic of Digital Signatures on Ethereum
https://medium.com/mycrypto/the-magic-of-digital-signatures-on-ethereum-98fe184dc9c7

- Проверка r, s и v (Calls ecrecover(hash, v, r, s), and Returns the Ethereum address of the signer that signed the message)
Подписи ECDSA в Ethereum состоят из трех параметров r, s и v. Solidity предоставляет глобально доступный метод ecrecover, 
который возвращает адрес с учетом этих трех параметров. Если возвращаемый адрес совпадает с адресом подписавшего, то подпись действительна.
Подписи, созданные с web3.js с помощью конкатенации r, s, и v, поэтому необходимым первым шагом является обратное разделение этих параметров.
И смарт-контракты, и клиенты Ethereum имеют возможность проверять подписи ECDSA. Обратите внимание, что любая попытка подделать хэш сообщения 
или подпись приведет к тому, что декодированный адрес будет отличаться от адреса подписавшего. Это гарантирует, что целостность сообщения 
и подписавшего может быть обеспечена хорошее обьяснение: 
```
Вы можете чередовать операторы Solidity со встроенным кодом ассемблера, близком к языку виртуальной машины Ethereum. 
Это дает вам более детальный контроль, что особенно полезно, когда вы улучшаете язык, создавая библиотеки.
Встроенная сборка — это способ доступа к виртуальной машине Ethereum на низком уровне. 
Это обходит несколько важных функций безопасности и проверок Solidity. Вы должны использовать его только для задач, 
которые в нем нуждаются, и только если вы уверены в его использовании.
Блок встроенного ассемблера помечен значком, где код внутри фигурных скобок — это код на языке Yul .assembly { ... }
:= присвоение и типизация перменной.
mload: 
 // Divide the signature in r, s and v variables with inline assembly
assembly { 
      r := mload(add(signature, 0x20)) 
      s := mload(add(signature, 0x40))
      v := byte(0, mload(add(signature, 0x60)))
    } 	
https://ethereum.stackexchange.com/questions/9603/understanding-mload-assembly-function

https://solidity-by-example.org/signature/

- Подписи ECDSA в Ethereum состоят из трех параметров: v, r и s. Длина подписи всегда составляет 65 байт.
r= первые 32 байта подписи
s= вторые 32 байта подписи
v= последний 1 байт подписи
assembly {
            /*
            First 32 bytes stores the length of the signature

            add(sig, 32) = pointer of sig + 32
            effectively, skips first 32 bytes of signature

            mload(p) loads next 32 bytes starting at the memory address p into memory
            */

            // first 32 bytes, after the length prefix
            r := mload(add(sig, 32))
            // second 32 bytes
            s := mload(add(sig, 64))
            // final byte (first byte of the next 32 bytes)
            v := byte(0, mload(add(sig, 96)))
        }

        // implicitly return (r, s, v)
```

- Contract ABI Specification — Solidity 0.8.11 documentation
https://docs.soliditylang.org/en/v0.8.11/abi-spec.html
Через abi.encodePacked(), Solidity поддерживает нестандартный упакованный режим, в котором: типы короче 32 байт 
объединяются напрямую, без заполнения или расширения знака. динамические типы кодируются на месте и без длины. 
элементы массива дополняются, но все еще кодируются на месте.

#### Основы HASH, SEED, Merkle tree

- ХЭШ функция для чайников | Хеширование | Хранение паролей https://www.youtube.com/watch?v=Bul0XYMa8Jg
- SEED фраза подробный разбор: https://www.youtube.com/watch?v=sCMFWx0MkBI
- Как создается мнемоническая фраза (Seed): https://www.youtube.com/watch?v=skLvrhv8etU&t=129s
```
Разные утилиты: 
- encoding and encryption online: https://cryptii.com/ 
- конвертр binary-to-decimal: https://www.rapidtables.com/convert/number/binary-to-decimal.html 
- 2048 mnemonik words: https://github.com/bitcoin/bips/blob/master/bip-0039/english.txt
- Понимание BIP32, BIP44, BIP39, участвующих в разработке HD-кошельков https://russianblogs.com/article/2264311352/
- BIP32 Deterministic Key Generator http://bip32.org/ 
- Mnemonic Code Converter https://iancoleman.io/bip39/ 
- https://emn178.github.io/online-tools/keccak_256.html Keccak-256 online hash function
- Online Solidity Decompiler https://ethervm.io/decompile

https://abi.hashex.org/  Online ABI Encoding Service (1 в ремикс скомпилируй контракт, внизу жмакай ABI, 2 далее содержимое вставляй форму по ссылке
выбирай поля и копируй код в 16ричном формате для аргуменов конструктора)


- signatures in the database https://www.4byte.directory/ 
Вызовы функций в виртуальной машине Ethereum определяются первыми четырьмя байтами данных, отправленных с транзакцией. 
Эти 4-байтовые подписи определяются как первые четыре байта хэша Keccak (SHA3) канонического представления подписи функции.
Эта база данных предназначена для того, чтобы позволить отображать эти байтовые подписи обратно в их удобочитаемые версии.

 преобразовании байтов в шестнадцатеричный формат. Очень просто: 1 байт данных = 2 шестнадцатеричных символа. 
 Всякий раз, когда вы видите строку шестнадцатеричных символов, вы можете разделить количество символов на 2, 
 чтобы получить размер в байтах. Любой «0x» в начале игнорируется при расчете. 32 байта (64 шестнадцатеричных символа).
 Потому что Эфириум использует блоки размером 32 байта, а почти все примитивные типы имеют размер 32 байта. 
 Однако есть несколько исключений, таких как тип «bytes»
 пример: параметр "to" 000000000000000000000000dac17f958d2ee523a2206206994597c13d831ec7 имеет тип address
 Адреса Ethereum представляют собой 20-байтовые значения, поэтому они были дополнены нулями, чтобы соответствовать 
 32-байтовому значению. Чтобы получить фактический адрес, нужно извлечь последние 20 байт и префикс 0x.
 Префикс «0x» означает шестнадцатеричный код, и это способ сообщить программам, контрактам, API-интерфейсам, 
 что входные данные следует интерпретировать как шестнадцатеричное число (сокращаем до шестнадцатеричного)
 
 https://www.trustology.io/insights-events/decoding-an-ethereum-transaction-its-no-secret-its-just-smart
```

Merkle Tree
- Solidity и смарт-контракты Ethereum, урок #8 | Древо Меркла, хэши, encode, циклы https://www.youtube.com/watch?v=aYKt-usrPw8
https://github.com/bodrovis-learning/Solidity-YT-Series/commit/df07318d15f568fcd942acd29266994f5be7092d#diff-edba9b9f724a0942067d16e34d978bd42ed186fc4f937768c6c7b5e8af5a84a0
- Строение блокчейна (дерево Меркла) https://intuit.ru/studies/courses/22093/762/lecture/32524  


#### Solidity Bytecode - Как работает сборка и коды операций в Solidity

- Solidity Bytecode and Opcode Basics https://medium.com/@blockchain101/solidity-bytecode-and-opcode-basics-672e9b1a88c2
- Deep dive into the Minimal Proxy contract https://blog.openzeppelin.com/deep-dive-into-the-minimal-proxy-contract/
- Online Solidity Decompiler https://ethervm.io/decompile
- коды операций виртуальной машины Ethereum  https://www.evm.codes/
- Mathematical and Cryptographic Functions
  https://docs.soliditylang.org/en/v0.8.0/units-and-global-variables.html#mathematical-and-cryptographic-functions 

Примеры:

Inline Assembly https://docs.soliditylang.org/en/develop/assembly.html
- mload как работает https://ethereum.stackexchange.com/questions/9603/understanding-mload-assembly-function
- Layout in Memory https://docs.soliditylang.org/en/v0.8.7/internals/layout_in_memory.html 
- Учебное пособие по Solidity: все о байтах https://jeancvllr.medium.com/solidity-tutorial-all-about-bytes-9d88fdb22676
- прекомпиляции EVM https://ethervm.io/#3F

#### ERC20 контракт для моста:

- ERC20Burnable.sol 
метод burnFrom() из ERC20Burnable.sol более универсальный чем простой _burn из ERC20 
- вызов Token(tokens[_symbol]).burnFrom(msg.sender, _amount); // msg.sender адрес у которого будут сожжены токены в количестве _amount,
// при вызове метода burnFrom необходимо предварительно получить approve к в контракте токена где spender это адресс контракта моста.    
https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.5.0/contracts/token/ERC20/extensions/ERC20Burnable.solhttps://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.5.0/contracts/token/ERC20/extensions/ERC20Burnable.sol
- _spendAllowance https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.5.0/contracts/token/ERC20/ERC20.sol

- TokenForBridgeWithBurnable(TFB2) https://rinkeby.etherscan.io/address/0x87d7245c500c76c77a1f12b58708cfcfcce4a19c

#### Быстрая верификация контракта через плагин Etherscan в remix: 

1 ставим в ремикс плагин ETHERSCAN - CONTRACT VERIFICATION
2 передаем в плагин api ключ etherscan
3 если необходимо передавать аргументы в конструктор в 16ричном формате тогда: 
https://abi.hashex.org/  Online ABI Encoding Service (1 в ремикс скомпилируй контракт, внизу жмакай ABI, 2 далее содержимое вставляй форму по ссылке
заполняй поля и копируй код в 16-ричном формате для аргуменов в конструктор)

#### Testing report   

```
function getChainID() external view returns (uint256) {
    uint256 id;
    assembly {
        id := chainid()
    }
    return id;
}
```
