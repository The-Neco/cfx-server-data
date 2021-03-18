import { useData } from "./context/ScoreboardContext"
import './App.css';

export default function Scoreboard() {
	const { columns } = useData();
	return (
		<div className="scoreboard">
			<table className="content-table">
				<thead>
					<tr>
						<th>ID</th>
						<th>Name</th>
						<th>Name</th>
						<th>Name</th>
						<th>Name</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>1</td>
						<td>Chip</td>
						<td>Chip</td>
						<td>Chip</td>
						<td>Chip</td>
					</tr>
					<tr>
						<td>2</td>
						<td>Neco</td>
						<td>Neco</td>
						<td>Neco</td>
						<td>Neco</td>
					</tr>
				</tbody>
			</table>
		</div>
	)
}