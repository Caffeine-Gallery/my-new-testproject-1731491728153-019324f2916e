import Char "mo:base/Char";
import Int "mo:base/Int";
import Nat "mo:base/Nat";
import Nat32 "mo:base/Nat32";

import Float "mo:base/Float";
import Text "mo:base/Text";
import Iter "mo:base/Iter";
import Debug "mo:base/Debug";

actor Calculator {
    public func calculate(expression : Text) : async Text {
        var result : Float = 0;
        var currentNum : Float = 0;
        var currentOp : Text = "+";
        
        for (char in expression.chars()) {
            if (char >= '0' and char <= '9') {
                currentNum := currentNum * 10 + Float.fromInt(Nat32.toNat(Char.toNat32(char) - Char.toNat32('0')));
            } else if (char == '+' or char == '-' or char == '*' or char == '/') {
                result := applyOperation(result, currentNum, currentOp);
                currentNum := 0;
                currentOp := Text.fromChar(char);
            };
        };
        
        result := applyOperation(result, currentNum, currentOp);
        
        return Float.toText(result);
    };
    
    private func applyOperation(left : Float, right : Float, op : Text) : Float {
        switch (op) {
            case "+" { left + right };
            case "-" { left - right };
            case "*" { left * right };
            case "/" { 
                if (right == 0) {
                    Debug.print("Division by zero!");
                    return 0;
                };
                left / right 
            };
            case _ { 
                Debug.print("Unknown operation: " # op);
                0 
            };
        };
    };
}
