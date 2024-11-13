import 'package:dartz/dartz.dart';

import '../../../utils/failures.dart';

abstract class UseCase<T, P> {
  Future<Either<Failure, T>> call(P params);
}
