# xEdit-API（中文说明）

GUI 编辑能力全覆盖工作已启动：见 [覆盖矩阵与任务顺序](GUI_API_COVERAGE.md)。
首批新增 [精确元素读取与编辑条件发现](API_ELEMENT_INSPECTION.md)，尚待编译与运行时验证。

开发中：结构化字段 diff、请求前置条件、会话内幂等及受保护的字段回滚，详见
[API_CHANGE_SAFETY.md](API_CHANGE_SAFETY.md)。新增代码尚待 Delphi 编译和运行时验证；
已有写端点不会自动生成回滚历史。

基于 **[TES5Edit/TES5Edit](https://github.com/TES5Edit/TES5Edit)**（ElminsterAU 的 xEdit 代码库）的二次开发分支：为 xEdit（主要面向 **SSEEdit / 上古卷轴5：天际特别版**）内置一个**进程内 HTTP/JSON API**，并提供一套**通用“原子能力”层**——外部工具与 AI agent 通过**组合少量通用原语**即可完成几乎任意 patch/编辑需求，**无需针对每个新需求修改 xEdit 源码**。

**已验证环境**：Windows + **Delphi 13 Community Edition（RAD Studio 37.0）**，工程配置 `LiteDebug / Win64`，基线 `dev-4.1.6`。

> English version: **[README.md](README.md)**

---

## 一、亮点

- xEdit 进程内 localhost HTTP/1.1+JSON 服务（`-api` 开关）。
- 全部操作在 xEdit **主线程任务泵**中执行，结果与在 GUI 里操作一致。
- **读**：插件/加载顺序/记录/覆盖链/元素树（含原始值）。
- **写**（仅内存）：改字段值、跨记录复制元素、列表项增删、master 维护、建补丁插件；以及 **`POST /api/batch`** 把这些原语编排成一条工作流。
- **不提供保存，这是刻意的**：API 无法把插件写盘。落盘始终由用户决定，并在 xEdit 界面里完成（文件 > 保存 / Ctrl+S）。
- **自发现**：`GET /api` 返回全部端点索引（agent 可直接探测）。

| 新增代码 | 作用 |
|---|---|
| `Core/wbApiServer.pas` | 整个服务端：socket、主线程泵、端点、通用路径解析器、batch 引擎 |
| `xEdit.dpr` / `xEdit\xeInit.pas` / `xEdit\xeMainForm.pas` | 薄接线 + GUI 回调（新建文件） |
| `api-client/xedit_api_client.py` | 零依赖 Python 客户端 |
| `Tools/delphi13-compat/` | Delphi 13 构建补丁（submodule 更新后重放） |
| `API_SERVER_DESIGN.md` / `DEV_SETUP_M0.md` | 中文设计/构建文档 |

---

## 二、构建与运行

1. 安装 **Delphi 13 CE**（**只能在 IDE 内编译**：`dcc32`/`msbuild` 会报 *“This version of the product does not support command line compiling.”*，且 `msbuild` 此时**退出码仍为 0** 却什么都没编——不要用退出码判断编译结果）。
2. `git submodule update --init --recursive`
3. `Tools\delphi13-compat\apply-patches.cmd`
4. Delphi 打开 `xEdit.dproj` → **LiteDebug / Win64** → `Project > Build`。（打开时的 “Error Reading Form: frmMain … VirtualEditTree” 属预期，点 **Cancel**，勿在设计器保存。）
5. 运行：

```bat
copy Build\xEdit.exe Build\SSEEdit.exe
SSEEdit.exe -SSE -api:7000            :: 可选：-apitoken:mysecret
```

GUI 加载插件完成后 API 就绪（`pluginsLoaded: true`）。API 做的修改都只在内存里——确认无误后到界面里保存。

---

## 三、API 参考

约定：
- 基址 `http://127.0.0.1:7000`。
- 成功 `{"ok":true,...}`；失败 `{"ok":false,"error":{"code","message"}}`。
- FormID 一律 8 位十六进制加载顺序 FormID（如 `030008D2`）。
- 启用 `-apitoken` 后除 `/api/status` 外都要带 `Authorization: Bearer <token>`。
- **元素路径**：显示名段用 `\` 连接，数字段表示列表下标（`Actor Effects\0`、`Keywords\KWDA - Keywords\0`、`DATA - DATA\Body Biped Object`）。从 `tree` 直接照抄的路径可以直接用——它带的记录根前缀（`RACE \ FULL - Name`）会被容忍；只写 signature（`FULL`）也仍按 xEdit 原生语法解析。

| 方法与路径 | 说明 |
|---|---|
| `GET /api` | 端点索引（agent 自发现） |
| `GET /api/status` | 应用/游戏模式、`pluginsLoaded`、端口 |
| `GET /api/plugins` / `.../{fileName}` | 加载顺序插件列表 / 单插件（ESM/ESL 标志、master 列表） |
| `GET /api/plugins/{file}/records?signature&editorID&offset&limit&names` | 记录分页列表 |
| `GET /api/plugins/{file}/records/{formID}` | 记录元数据 + 完整覆盖链 |
| `GET /api/records/{formID}` | 跨加载顺序解析记录 + 覆盖链 |
| `GET /api/plugins/{file}/records/{formID}/tree?depth` | 元素树 JSON（`name/path/value/children`，含原始值） |
| `POST .../records/{formID}/values` | 批量改字段：`{"values":{"FULL - Name":"..."}}` |
| `POST .../records/{formID}/copy-elements` | 按显示名复制**顶层元素**：`{"source":{"file","formID"},"elements":["DATA - DATA", ...]}`（要按任意路径复制请用 batch 的 `copy` op） |
| `POST .../plugins/{file}/addmasters` | 按名补 master |
| `POST /api/patch` | 建补丁插件（`{"fileName","isLight","records":[...]}`）；同名已加载或磁盘已存在时返回 409 `file_exists`（不会落到 GUI 弹模态框卡住） |
| `GET /api/find?editorID&signature&file&exact&limit` | 跨插件按 EDID 查找（exact 优先用 EDID 索引，缺失时回退为按分组扫描；响应含 `edidIndexEnabled`） |
| `POST /api/batch` | 通用原语编排器（见下） |

### `POST /api/batch` —— 通用原子操作编排

请求：`{"strict": bool, "ops":[{"op":"...", ...}]}`。op 依序在主线程执行，逐条返回结果。**batch 只改内存，绝不落盘**。看完结果确认无误后，再到 xEdit 界面里保存（不保存关闭即全部丢弃）。

```json
{ "strict": false,
  "ops": [
    { "op": "set", "file": "MyMod.esp", "formID": "010008D2",
      "values": { "FULL - Name": "New name", "DATA - DATA\\Base Carry Weight": "400" } },
    { "op": "copy", "file": "MyMod.esp", "formID": "010008D2",
      "source": { "file": "BaseMod.esm", "formID": "000008D2" }, "path": "DESC - Description" },
    { "op": "add-item", "file": "MyMod.esp", "formID": "010008D2", "path": "Actor Effects" },
    { "op": "remove-item", "file": "MyMod.esp", "formID": "010008D2", "path": "Actor Effects\\2" },
    { "op": "masters", "file": "MyMod.esp", "add": ["BaseMod.esm"], "sort": true }
  ] }
```

支持 op：`set`、`copy`、`add-item`、`remove-item`、`create-record`、`masters`。路径段支持名称或数字下标；`copy` 在目标缺失时会在父容器下自动补建可选子记录；`create-record` 把源记录克隆为**全新记录**（新 FormID，可选 `editorID` 与 `values`），用于“生成内容”而非仅覆盖。（`op: "save"` 会被拒绝——见上面的保存说明。）

### 客户端示例（零依赖）

```powershell
python api-client\xedit_api_client.py status
python api-client\xedit_api_client.py plugins
python api-client\xedit_api_client.py records --file "MyMod.esp" --signature RACE --names --limit 20
python api-client\xedit_api_client.py tree --file "MyMod.esp" --record 010008D2 --depth 4
python api-client\xedit_api_client.py set --file "MyMod.esp" --record 010008D2 --values-file values.json
python api-client\xedit_api_client.py patch --patch-file patch.json
```

之后到 xEdit 界面里保存——客户端同样没有 save 子命令。

`api-client\verify_api.py` 是策略/回归验证脚本（读链路冒烟，并确认 save 端点与 batch `save` op 确实已移除；可选 `--write-test` 做内存往返编辑）。

---

## 四、已知限制 / 规划

- **API 不提供保存能力**：`/api/plugins/{file}/save` 端点不存在，batch 的 `save` op 会被拒绝。API 改的东西只在内存里，必须由用户在 xEdit 界面保存；不保存关闭即全部丢弃。
- 修改仅内存态且无日志/快照（除 xEdit 自身行为外没有 undo）。
- 超大数据记录深 `tree` 较慢——尽量用 `signature` 过滤或限制 `depth`。
- batch `copy` 引用字段前需先通过 `masters` op 添加对应插件为 master（否则引用会被置空；先加 master 再复制）。
- 规划：tree 紧凑模式、undo/快照。

---

## 五、基于本 fork 开发

```bat
git remote rename origin upstream
git remote add origin git@github.com:<你的账号>/xEdit-API.git
git switch -c dev-4.1.6-api
git push -u origin dev-4.1.6-api
```

同步上游：`git fetch upstream && git merge upstream/dev-4.1.6`，随后 `git submodule update --init --recursive` 并重跑 `Tools\delphi13-compat\apply-patches.cmd`。

代码指引：
- 服务端全部在 `Core/wbApiServer.pas`：`HandleRequest` 加路由、handler 在主线程跑、用 `RespondJson` 应答。
- 依赖 GUI 的动作（新建文件）走 `xeMainForm.WMUserLoaderDone` 注册的回调。API **刻意不注册**保存回调——这正是它没有写盘能力的根本原因。
- 尽量不动 `wbInterface.pas` / `wbImplementation.pas`，保持与上游易合并。

致谢与许可：上游 xEdit 由 ElminsterAU 及贡献者维护（[仓库](https://github.com/TES5Edit/TES5Edit)，MPL-2.0）。本分支保留 MPL-2.0 许可与文件头。
