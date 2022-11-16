import base64
import mne
import scipy.io as scio
import numpy as np
from flask import Flask, request
from flask_cors import CORS
import os

os.environ['KMP_DUPLICATE_LIB_OK'] = 'TRUE'

app = Flask(__name__)
CORS(app, supports_credentials=True)


@app.route('/test', methods=['GET'])
def test():
    return "halo"


if __name__ == '__main__':
    # 这里host是你的后端地址，这里写0.0.0.0， 表示的是这个接口在任何服务器上都可以被访问的到，只需要前端访问该服务器地址就可以的，
    # 当然你也可以写死，如222.222.222.222， 那么前端只能访问222.222.222.222, port是该接口的端口号,
    # debug = True ,表示的是，调试模式，每次修改代码后不用重新启动服务
    app.run(host='0.0.0.0', port=5000, debug=True)
