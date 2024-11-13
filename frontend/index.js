import { backend } from 'declarations/backend';

let display = document.getElementById('display');

window.appendToDisplay = (value) => {
    display.value += value;
};

window.clearDisplay = () => {
    display.value = '';
};

window.calculate = async () => {
    try {
        const expression = display.value;
        const result = await backend.calculate(expression);
        display.value = result;
    } catch (error) {
        display.value = 'Error';
        console.error('Calculation error:', error);
    }
};
