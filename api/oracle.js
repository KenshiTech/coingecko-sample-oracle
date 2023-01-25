import fetch from "node-fetch";
import { ethers } from "ethers";

const url =
  "https://api.coingecko.com/api/v3/coins/kenshi/market_chart?vs_currency=usd&days=1";

const fetchPrice = async () => {
  const resp = await fetch(url);
  const { prices } = await resp.json();
  const slice = prices.slice(-6); // last 30 minutes
  const average = slice.map(([_, price]) => price).reduce((a, b) => a + b) / 6;
  return average;
};

export default async function handler(request, response) {
  const price = await fetchPrice();
  response.status(200).json({
    method: "setPrice",
    args: [ethers.utils.parseUnits(price.toFixed(18)).toString()],
    maxGas: "10000000000000000", // 0.01 ETH
    abort: false,
  });
}
