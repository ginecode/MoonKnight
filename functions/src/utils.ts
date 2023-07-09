import { Const } from "./gen/chat_pb";

export function renameMapKeys<K extends string | number | symbol, V>(originalMap: Map<K, V>, keyMapping: Record<K, K>) {
    // Create a new Map to hold the modified key-value pairs
    const newMap = new Map<K, V>()

    // Iterate over the original map and copy each key-value pair to the new map with modified keys
    for (const [key, value] of originalMap.entries()) {
        const newKey = keyMapping[key] || key // Use the mapped key if available, otherwise use the original key
        newMap.set(newKey, value)
    }

    return Object.fromEntries(newMap.entries());
}

export function getConst(name: number) {
    return Object.entries(Const).filter(v => {
        return (v[1] == name);
    })[0][0].toLowerCase();
}