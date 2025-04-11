/// @function approach(current, target, amount)
/// @param {real} current Current value
/// @param {real} target Target value
/// @param {real} amount Amount to change
function approach(current, target, amount) {
    if (current < target) {
        return min(current + amount, target);
    } else {
        return max(current - amount, target);
    }
}