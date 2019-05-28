pragma solidity ^0.4.19;

library StringUtils {
    function toNaIfEmpty(string self) internal pure returns(string) {
        return isEmpty(self) ? "N/A" : self;
    }

    function isEmpty(string self) internal pure returns(bool) {
        return (bytes(self).length == 0);
    }

    function toLower(string self) internal pure returns (string) {
        //based on https://gist.github.com/ottodevs/c43d0a8b4b891ac2da675f825b1d1dbf
        bytes memory bStr = bytes(self);
        bytes memory bLower = new bytes(bStr.length);
        for (uint i = 0; i < bStr.length; i++) {
            // Uppercase character...
            if ((bStr[i] >= 65) && (bStr[i] <= 90)) {
                // So we add 32 to make it lowercase
                bLower[i] = bytes1(int(bStr[i]) + 32);
            } else {
                bLower[i] = bStr[i];
            }
        }
        return string(bLower);
    }
}
