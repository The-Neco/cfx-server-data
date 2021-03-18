import { useData } from "./context/ScoreboardContext"

export default function Scoreboard() {
	const { columns } = useData();
	return (
		<div>
			<h1>HSSHSHHSSH  {columns.id?.friendlyName}</h1>
		</div>
	)
}