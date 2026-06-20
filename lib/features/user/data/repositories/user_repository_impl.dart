import 'package:logger/logger.dart';
import 'package:product_app/core/errors/faliure.dart';
import 'package:product_app/features/user/data/models/login_model.dart';
import 'package:product_app/features/user/data/models/user_model.dart';
import 'package:product_app/features/user/data/datasources/user_local_datasource.dart';
import 'package:product_app/features/user/data/datasources/user_remote_datasource.dart';
import 'package:product_app/features/user/domain/entities/login.dart';
import 'package:product_app/features/user/domain/entities/user.dart';
import 'package:product_app/features/user/domain/repositories/user_repository.dart';

Logger logger = Logger();

class UserRepositoryImpl implements UserRepository{
    final UserLocalDatasource local = UserLocalDatasource();
    final UserRemoteDatasource remote = UserRemoteDatasource();

    UserRepositoryImpl();

    @override 
    Future<void> saveTokenCache(String token) async{
        try {
            local.saveToken(token);
        } catch(e, stack) {
            logger.e(e, stackTrace: stack);
            throw Failure("Erro ao tentar salvar o token no cache");
        }
    }

    @override
    Future<void> saveUserCache(UserModel user) async {
        try {
            local.saveUser(user);
        } catch(e, stack) {
            logger.e(e, stackTrace: stack);
            throw Failure("Erro ao tentar salvar o usuáro no cache");
        }
    }

    @override
    Future<String> getTokenCache() async {
        try {
            return await local.retrieveToken();
        } catch(e, stack) {
            logger.e(e, stackTrace: stack);
            throw Failure("Erro ao buscar o token salvo no cache: ${e.toString()}");
        }
    }

    @override
    Future<User> getUserCache() async {
        try {
            final userCache = await local.getMe();
            return User(
                id: userCache.id,
                email: userCache.email,
                username: userCache.username,
                firstName: userCache.firstName,
                lastName: userCache.lastName,
                gender: userCache.gender,
                image: userCache.image,
                accessToken: userCache.accessToken,
                refreshToken: userCache.refreshToken
            );
        } catch (e, stack) {
            logger.e(e, stackTrace: stack);
            throw Failure("Erro ao buscar o usuário salvo no cache: ${e.toString()}");
        }
    }

    @override
    Future<void> deleteTokenCache() async {
        try {
            await local.removeToken();
        } catch(e, stack) {
            logger.e(e, stackTrace: stack);
            throw Failure("Erro ao apagar o token do cache: ${e.toString()}");
        }
    }

    @override
    Future<void> deleteUserCache() async {
        try{
            await local.removeUser();
        } catch(e, stack) {
            logger.e(e, stackTrace: stack);
            throw Failure("Erro ao apagar o usuário do cache: ${e.toString()}");
        }
    }

    @override
    Future<User?> getUser() async {
        try {
            final UserModel user = await remote.getMe();
            return User(
                id: user.id,
                email: user.email,
                username: user.username,
                firstName: user.firstName,
                lastName: user.lastName,
                gender: user.gender,
                image: user.image,
                accessToken: user.accessToken,
                refreshToken: user.refreshToken, 
            );
        } catch(e, stack) {
            logger.e(e, stackTrace: stack);
            throw Failure("Erro ao buscar o usuário: ${e.toString()}");
        }
    }

    @override
    Future<User> logIn(Login loginForm) async {
        try {
            final LoginModel login = LoginModel(
                username: loginForm.username, 
                password: loginForm.password,
            );
            final UserModel user = await remote.logIn(login);
            await local.saveLastLoginDate(DateTime.now());
            await local.saveSessionMinDuration(login.expiresInMins ?? 60);
            await local.saveToken(user.accessToken);
            await local.saveUser(user);
            return User(
                id: user.id, 
                email: user.email, 
                username: user.username, 
                firstName: user.firstName, 
                lastName: user.lastName, 
                gender: user.gender, 
                image: user.image, 
                accessToken: user.accessToken, 
                refreshToken: user.refreshToken
            );
        } catch(e, stack) {
            logger.e(e, stackTrace: stack);
            throw Failure("Falha no login: ${e.toString()}");
        }
    }

    @override
    Future<bool> checkSession(String token) async {
        try {
            final int duracaoDaSessao = (await local.retrieveSessionMinDuration() * 60000);
            final int dataAtual = DateTime.now().millisecondsSinceEpoch;
            final DateTime dataUltimoLogin = await local.retrieveLastLoginDate();
            final int diferencaDataLogin = dataAtual - dataUltimoLogin.millisecondsSinceEpoch;

            logger.d([
                dataUltimoLogin,
                dataAtual,
                duracaoDaSessao,
                diferencaDataLogin,
            ]);

            if(diferencaDataLogin > duracaoDaSessao) {
                return false;
            }

            return true;
        } catch(e, stack) {
            logger.e(e, stackTrace: stack);
            throw Failure("Erro ao conferir a validade da sessão: ");
        }
    }

}