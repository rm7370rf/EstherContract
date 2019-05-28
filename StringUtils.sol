pragma solidity ^0.4.19;

library StringUtils {
    function toNaIfEmpty(string self) internal pure returns(string) {
        return isEmpty(self) ? "N/A" : self;
    }

    function isEmpty(string self) internal pure returns(bool) {
        return (bytes(self).length == 0);
    }
}
