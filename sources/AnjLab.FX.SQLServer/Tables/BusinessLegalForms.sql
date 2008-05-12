/*
<summary>
	Russian Classification of Organizational and Legal Forms according to OKOPF
</summary>

<author>
	Alex Zakharov
	Copyright © AnjLab 2008, http://anjlab.com. All rights reserved.
	The code can be used for free as long as this copyright notice is not removed.
<author>

<date>2/10/2008</date>
*/

if not exists (select * from sysobjects where id = object_id(N'fx.BusinessLegalForms') and xtype ='U')
begin

CREATE TABLE fx.BusinessLegalForms (
	Code smallint not null,
	ParentCode smallint not null,
	Name nvarchar(512) not null,
	IsFavorite bit not null constraint DF_BusinessLegalFormsIsFavorite default 0,
	CONSTRAINT PK_BusinessLegalForms PRIMARY KEY CLUSTERED (Code ASC)
)		

EXEC sys.sp_addextendedproperty @name=N'MS_Description', 
	@value=N'Russian Classification of Organizational and Legal Forms according to OKOPF', 
	@level0type=N'SCHEMA', @level0name=N'fx', @level1type=N'TABLE',  @level1name=N'BusinessLegalForms'

EXEC sys.sp_addextendedproperty @name=N'MS_Description', 
	@value=N'You can use this flag to define legal forms which are used often (for example, to truncate full list)' , 
	@level0type=N'SCHEMA', @level0name=N'fx', @level1type=N'TABLE',  @level1name=N'BusinessLegalForms', @level2type=N'COLUMN',  @level2name=N'IsFavorite'



INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	39, 0,  N'ЮРИДИЧЕСКИЕ ЛИЦА, ЯВЛЯЮЩИЕСЯ КОММЕРЧЕСКИМИ ОРГАНИЗАЦИЯМИ')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	48, 39, N'Хозяйственные товарищества и общества')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	51, 39, N'Полные товарищества')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	64, 39, N'Товарищества на вере')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name, IsFavorite) VALUES(	65, 39, N'Общества с ограниченной ответственностью', 1)
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name, IsFavorite) VALUES(	66, 39, N'Общества с дополнительной ответственностью', 1)
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	60, 39, N'Акционерные общества')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name, IsFavorite) VALUES(	47, 39, N'Открытые акционерные общества', 1)
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name, IsFavorite) VALUES(	67, 39, N'Закрытые акционерные общества', 1)
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	52, 39, N'Производственные кооперативы')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	53, 39, N'Крестьянские (фермерские) хозяйства')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name, IsFavorite) VALUES(	40, 39, N'Унитарные предприятия', 1)
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	42, 39, N'Унитарные предприятия, основанные на праве хозяйственного ведения')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	41, 39, N'Унитарные предприятия, основанные на праве оперативного управления')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	70, 0,  N'ЮРИДИЧЕСКИЕ ЛИЦА, ЯВЛЯЮЩИЕСЯ НЕКОММЕРЧЕСКИМИ ОРГАНИЗАЦИЯМИ')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	85, 70, N'Потребительские кооперативы')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	83, 70, N'Общественные и религиозные организации (объединения)')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	84, 70, N'Общественные движения')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name, IsFavorite) VALUES(	88, 70, N'Фонды', 1)
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name, IsFavorite) VALUES(	81, 70, N'Учреждения', 1)
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	71, 70, N'Частные учреждения')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name, IsFavorite) VALUES(	72, 70, N'Бюджетные учреждения', 1)
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	73, 70, N'Автономные учреждения')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	78, 70, N'Органы общественной самодеятельности')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	96, 70, N'Некоммерческие партнерства')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	97, 70, N'Автономные некоммерческие организации')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	93, 70, N'Объединения юридических лиц (ассоциации и союзы)')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	77, 70, N'Объединения крестьянских (фермерских) хозяйств')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	80, 70, N'Территориальные общественные самоуправления')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	94, 70, N'Товарищества собственников жилья')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	76, 70, N'Садоводческие, огороднические или дачные некоммерческие товарищества')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	82, 70, N'Государственные корпорации')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	89, 70, N'Прочие некоммерческие организации')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	99, 0,  N'ОРГАНИЗАЦИИ БЕЗ ПРАВ ЮРИДИЧЕСКОГО ЛИЦА')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name, IsFavorite) VALUES(	92, 99, N'Паевые инвестиционные фонды', 1)
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	87, 99, N'Простые товарищества')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	90, 99, N'Представительства и филиалы')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	95, 99, N'Крестьянские (фермерские) хозяйства')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name) VALUES(	98, 99, N'Иные неюридические лица')
INSERT INTO fx.BusinessLegalForms(Code, ParentCode, Name, IsFavorite) VALUES(	91, 0,  N'Индивидуальные предприниматели', 1)

end
go