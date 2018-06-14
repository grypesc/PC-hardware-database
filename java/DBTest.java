package bdlab;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

public class DBTest {
	public static class CPU {
		private int id;
		private String name;
		private int cores;
		private int frequency;
		private int threads;
		private String producer  ;
		





		public CPU(int id, String name) {
			super();
			this.id = id;
			this.name = name;
		}

		public CPU() {
		}
		
		public int getId() {
			return id;
		}

		public void setId(int id) {
			this.id = id;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public int getCores() {
			return cores;
		}

		public void setCores(int cores) {
			this.cores = cores;
		}

		public int getFrequency() {
			return frequency;
		}

		public void setFrequency(int frequency) {
			this.frequency = frequency;
		}

		public int getThreads() {
			return threads;
		}

		public void setThreads(int threads) {
			this.threads = threads;
		}

		public String getProducer() {
			return producer;
		}

		public void setProducer(String producer) {
			this.producer = producer;
		}

		public String toString() {
			return String.format("CPU(%d, %s, %s, %d, %s, %s)", id, name, producer, frequency, cores, threads); 
		}
	}

	public final static ResultSetToBean<CPU> CPUConverter = new ResultSetToBean<CPU>() {
		public CPU convert(ResultSet rs) throws Exception {
			CPU e = new CPU();
			e.setId(rs.getInt("ID"));
			e.setName(rs.getString("NAME"));
			e.setProducer(rs.getString("PRODUCER"));
			e.setFrequency(rs.getInt("FREQUENCY"));
			e.setCores(rs.getInt("CORES"));
			e.setThreads(rs.getInt("THREADS"));
			return e;
		}
	};

	public static void main(String[] args) {

		boolean result = DBManager.run(new Task<Boolean>() {
			public Boolean execute(PreparedStatement ps) throws Exception {
				ps.setInt(1, 7);
				ps.setInt(2, 3600);
				return ps.executeUpdate() > 0;
			}
		}, "update cpu set cores = ? where frequency = ?");

		System.out.println(result ? "Udalo sie" : "Nie udalo sie");
		

		List<CPU> cpu = DBManager
				.run(new Query() {
					public void prepareQuery(PreparedStatement ps)
							throws Exception {
						ps.setInt(1, 2);
					}
				}, CPUConverter,
						"select id, name, producer, frequency, cores, threads from cpu where cores = ?");

		for (CPU e: cpu) {
			System.out.println(e);
		}
		
		List<CPU> cpu2 = DBManager
				.run(new Query() {
					public void prepareQuery(PreparedStatement ps)
							throws Exception {
						ps.setString(1,"Phenom");
						ps.setInt(2, 6);
						ps.setInt(3, 6);
						ps.setInt(4, 3000);
						ps.setString(5,"Intel");
						ps.setInt(6,404025);
					}
				}, CPUConverter,
						"insert into cpu values (?, ?, ?, ?, ?, ?)");
						
		List<CPU> cpu3 = DBManager
				.run(new Query() {
					public void prepareQuery(PreparedStatement ps)
							throws Exception {
						ps.setInt(1,4);
					}
				}, CPUConverter,
						"delete from CPU where cores = ?");

		List<CPU> cpu4 = DBManager
				.run(new Query() {
					public void prepareQuery(PreparedStatement ps)
							throws Exception {
						ps.setInt(1,4);
						ps.setInt(2, 2400);
					}
				}, CPUConverter,
						"UPDATE CPU SET CORES=? WHERE FREQUENCY=?");
						
	}

}
