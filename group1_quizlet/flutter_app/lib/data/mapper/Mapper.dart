abstract class Mapper<DM, DT> {
  DM mapToDomain(DT data);
  DT mapToData(DM domain);
}
