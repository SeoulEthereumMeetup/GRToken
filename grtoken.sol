pragma solidity ^0.4.8;

contract  GRToken {
    // (1) 상태 변수 선언
    string public name; // 토큰 이름
    string public symbol; // 토큰 단위
    uint8 public decimals; // 소수점 이하 자릿수
    uint256 public totalSupply; // 토큰 총량
    mapping (address => uint256) public balanceOf; // 각 주소의 잔고
    mapping (address => bool) public blackList; // 블랙리스트

    // (3) 이벤트 알림
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Blacklisted(address indexed target);
    event DeleteFromBlacklist(address indexed target);
    event RejectedPaymentToBlacklistedAddr(address indexed from, address indexed to, uint256 value);
    event RejectedPaymentFromBlacklistedAddr(address indexed from, address indexed to, uint256 value);
    event Cashback(address indexed from, address indexed to, uint256 value);

    // (4) 생성자
    function BangToken(uint256 _supply, string _name, string _symbol, uint8 _decimals) public {
        balanceOf[msg.sender] = _supply;
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _supply;
    }   
    
    function transfer(address _to, uint256 _value) public {
        // 부정 송금 확인
        if (balanceOf[msg.sender] < _value) revert();
        if (balanceOf[_to] + _value < balanceOf[_to]) revert();

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
    }

    function burnToken(uint256 _value) public {
        if (balanceOf[msg.sender] < _value) revert();

        totalSupply -= _value;
        balanceOf[msg.sender] -= _value;
    }
}

