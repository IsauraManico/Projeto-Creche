#app.py
from flask import Flask, render_template, request, redirect, url_for, flash
import psycopg2 #pip install psycopg2 
import psycopg2.extras
 
app = Flask(__name__)
app.secret_key = "cairocoders-ednalan"
 
DB_HOST = "localhost"
DB_NAME = "creche"
DB_USER = "postgres"
DB_PASS = "postgres"
 
conn = psycopg2.connect(dbname=DB_NAME, user=DB_USER, password=DB_PASS, host=DB_HOST)
 ##select aqui!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
@app.route('/')
def home():
 
    return render_template('index.html')

@app.route('/begin')
def Index():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    s = "SELECT * FROM criancas"
    cur.execute(s) # Execute the SQL
    list_users = cur.fetchall()
    return render_template('crianca.html', list_users = list_users)
 

@app.route('/add_student', methods=['POST'])
def add_student():
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    if request.method == 'POST':
        nome = request.form['nome']
        fk_encarregado=request.form['fk_encarregado']
        data_nasc= request.form['data_nasc']
        fk_turma=request.form['fk_turma']
        sexo=request.form['sexo']
       
        #print(fname,lname,email)
        cur.execute('INSERT INTO criancas (nome, fk_encarregado,data_nasc,fk_turma,sexo) VALUES (%s,%s,%s,%s,%s)', (nome, fk_encarregado,data_nasc,fk_turma,sexo))
        conn.commit()
        flash('Student Added successfully')
        return redirect(url_for('Index'))
 
@app.route('/edit/<id>', methods = ['POST', 'GET'])
def get_employee(id):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
   
    cur.execute('SELECT * FROM criancas WHERE pk_crianca = %s', (id))
    data = cur.fetchall()
    cur.close()
    print(data[0])
    return render_template('edit.html', student = data[0])
 
@app.route('/update/<id>', methods=['POST'])
def update_student(id):
    if request.method == 'POST':
        nome = request.form['nome']
        fk_encarregado=request.form['fk_encarregado']
        data_nasc= request.form['data_nasc']
        fk_turma=request.form['fk_turma']
        sexo=request.form['sexo']
        
        
         
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        cur.execute("""
            UPDATE criancas
            SET nome = %s,
                fk_encarregado=%s,
                data_nasc=%s,
                fk_turma=%s,
                sexo=%s,
            WHERE pk_crianca = %s
        """, (nome, fk_encarregado,data_nasc,fk_turma,sexo,id))
        flash('Student Updated Successfully')
        conn.commit()
        return redirect(url_for('Index'))
 
@app.route('/delete/<string:id>', methods = ['POST','GET'])
def delete_student(id):
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
   
    cur.execute('DELETE FROM criancas WHERE pk_crianca = {0}'.format(id))
    conn.commit()
    flash('Student Removed Successfully')
    return redirect(url_for('Index'))
@app.route('/sobre')
def sobre():
    return render_template('sobre.html')
@app.route('/entrar')
def entrar():
    return render_template('login.html')

@app.route('/eventos')
def eventos():
    return render_template('eventos.html')

@app.route('/galeria')
def galeria():
    return render_template('galeria.html')
@app.route('/contacto')
def contacto():
    return render_template('contacto.html')


 ####################################################turma####################################################


if __name__ == "__main__":
    app.run(debug=True)
'</string:id></id></id>'