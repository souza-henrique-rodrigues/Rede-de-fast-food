import mysql.connector 



banco = mysql.connector.connect(
    host = 'localhost',
    user = 'root',
    password = '123',
    database = "lanchonete"
)

cursor = banco.cursor()

sigla = input("Informe a sigla do estado: ")
estado = input("Informe o nome do estado: ")

codigoSQL = f'INSERT INTO estado (sigla_estado,estado) VALUES("{sigla}","{estado}")'


cursor.execute(codigoSQL)
banco.commit()

print(cursor.rowcount,'registro(s) inserido(s).')

cursor.close()
banco.close()